import argparse
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_LITTLE_ENDIAN, CS_MODE_THUMB
from elftools.elf.elffile import ELFFile


def load_symbols(elf):
    result = []
    for section_name in (".dynsym", ".symtab"):
        section = elf.get_section_by_name(section_name)
        if section is None:
            continue
        for symbol in section.iter_symbols():
            if symbol["st_value"] and symbol.name:
                result.append((symbol.name, symbol["st_value"], symbol["st_size"], section_name))
    return result


def virtual_to_offset(elf, address):
    for segment in elf.iter_segments():
        if segment["p_type"] != "PT_LOAD":
            continue
        start = segment["p_vaddr"]
        end = start + segment["p_filesz"]
        if start <= address < end:
            return segment["p_offset"] + address - start
    raise ValueError(f"address 0x{address:x} is not file-backed")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("elf")
    parser.add_argument("--match", default="MQLanguageStub_Run")
    parser.add_argument("--address", type=lambda value: int(value, 0))
    parser.add_argument("--lookup", nargs="*", type=lambda value: int(value, 0))
    parser.add_argument("--bytes", type=int, default=1024)
    args = parser.parse_args()

    path = Path(args.elf)
    with path.open("rb") as stream:
        elf = ELFFile(stream)
        symbols = load_symbols(elf)
        matches = [item for item in symbols if args.match.lower() in item[0].lower()]
        if args.address is not None:
            matches = [(f"sub_{args.address:x}", args.address, args.bytes, "manual")]
        print(f"ELF machine={elf['e_machine']} entry=0x{elf['e_entry']:x} symbols={len(symbols)}")
        if args.lookup:
            ordered = sorted(symbols, key=lambda item: item[1] & ~1)
            for target in args.lookup:
                candidates = [item for item in ordered if (item[1] & ~1) <= target]
                if not candidates:
                    print(f"lookup 0x{target:x}: no preceding symbol")
                    continue
                name, value, size, source = candidates[-1]
                delta = target - (value & ~1)
                print(f"lookup 0x{target:x}: {name}+0x{delta:x} value=0x{value:x} size={size} {source}")
        for name, value, size, source in matches:
            thumb = bool(value & 1)
            address = value & ~1
            offset = virtual_to_offset(elf, address)
            amount = min(size or args.bytes, args.bytes)
            stream.seek(offset)
            code = stream.read(amount)
            mode = CS_MODE_LITTLE_ENDIAN | (CS_MODE_THUMB if thumb else CS_MODE_ARM)
            md = Cs(CS_ARCH_ARM, mode)
            md.detail = True
            print(f"\n{name} source={source} value=0x{value:x} address=0x{address:x} size={size} thumb={thumb}")
            for insn in md.disasm(code, address):
                print(f"0x{insn.address:08x}: {insn.mnemonic:9} {insn.op_str}")

        if not matches:
            print("No matching symbol. Related exports:")
            for name, value, size, source in symbols:
                if any(part in name.lower() for part in ("mqlanguage", "mqauxiliary", "run", "lua")):
                    print(f"0x{value:x} {size:6} {source} {name}")


if __name__ == "__main__":
    main()
