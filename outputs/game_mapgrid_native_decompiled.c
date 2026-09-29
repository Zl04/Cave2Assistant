/* Named Ghidra decompilation: libcocos2dlua.so */
/* Matches: 3 */

/* ============================================================ */
/* saveMapGridToFile @ 007f037c */

/* Avalon::MapGrid::saveMapGridToFile(char*, std::string&) */

void Avalon::MapGrid::saveMapGridToFile(char *param_1,string *param_2)

{
  char cVar1;
  bool bVar2;
  long *plVar3;
  long lVar4;
  long lVar5;
  int *piVar6;
  int iVar7;
  long local_10;
  long local_8;
  
                    /* try { // try from 007f038c to 008f038f has its CatchHandler @ 007f2850 */
                    /* try { // try from 007f03a4 to 008f03a7 has its CatchHandler @ 007f2844 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  plVar3 = (long *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 007f03bc to 008f03bf has its CatchHandler @ 007f2838 */
  (**(code **)(*plVar3 + 0x118))(&local_10,plVar3,param_2);
  lVar4 = fopen(local_10,&DAT_0127e510);
                    /* try { // try from 007f03d4 to 008f03d7 has its CatchHandler @ 007f282c */
                    /* try { // try from 007f03ec to 008f03ef has its CatchHandler @ 007f2820 */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 007f04ac to 008f04af has its CatchHandler @ 007f27c0 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar7 = *(int *)(local_10 + -8);
                    /* try { // try from 007f04dc to 008f04df has its CatchHandler @ 007f27a8 */
      *(int *)(local_10 + -8) = iVar7 + -1;
    }
    else {
      piVar6 = (int *)(local_10 + -8);
      do {
        iVar7 = *piVar6;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar6,0x10);
        if (bVar2) {
          *piVar6 = iVar7 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
                    /* try { // try from 007f04c4 to 008f04c7 has its CatchHandler @ 007f27b4 */
    if (iVar7 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  if (lVar4 != 0) {
                    /* try { // try from 007f0404 to 008f0407 has its CatchHandler @ 007f2814 */
    if (0 < DAT_01725008) {
      lVar5 = (long)DAT_0172500c;
      iVar7 = 0;
                    /* try { // try from 007f041c to 008f041f has its CatchHandler @ 007f2808 */
      do {
        iVar7 = iVar7 + 1;
        fwrite(param_1,lVar5,1,lVar4);
                    /* try { // try from 007f0434 to 008f0437 has its CatchHandler @ 007f27fc */
        fwrite(&DAT_0127e518,1,1,lVar4);
                    /* try { // try from 007f044c to 008f044f has its CatchHandler @ 007f27f0 */
        fwrite("n",1,1,lVar4);
        lVar5 = (long)DAT_0172500c;
                    /* try { // try from 007f0464 to 008f0467 has its CatchHandler @ 007f27e4 */
        param_1 = param_1 + lVar5;
      } while (iVar7 < DAT_01725008);
    }
    fclose(lVar4);
  }
                    /* try { // try from 007f047c to 008f047f has its CatchHandler @ 007f27d8 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 007f0494 to 008f0497 has its CatchHandler @ 007f27cc */
    return;
  }
                    /* WARNING: Subroutine does not return */
                    /* try { // try from 007f050c to 008f050f has its CatchHandler @ 007f2790 */
  __stack_chk_fail();
}



/* ============================================================ */
/* setPvrEncryptionKeyPart @ 00fb5528 */

/* cocos2d::ZipUtils::setPvrEncryptionKeyPart(int, unsigned int) */

void cocos2d::ZipUtils::setPvrEncryptionKeyPart(int param_1,uint param_2)

{
  if (*(uint *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + (long)param_1 * 4) != param_2) {
    *(uint *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + (long)param_1 * 4) = param_2;
    *PTR_s_bEncryptionKeyIsValid_0171a260 = 0;
  }
  return;
}



/* ============================================================ */
/* setPvrEncryptionKey @ 00fb5550 */

/* cocos2d::ZipUtils::setPvrEncryptionKey(unsigned int, unsigned int, unsigned int, unsigned int) */

uint cocos2d::ZipUtils::setPvrEncryptionKey(uint param_1,uint param_2,uint param_3,uint param_4)

{
  return param_1;
}



