/* Ghidra decompilation: libmqm.so */

/* ============================================================ */
/* Target 0x43548 */
/* Ghidra name: FUN_00043438 */
/* Entry: 00043438 */

void FUN_00043438(undefined4 *param_1,int param_2,int param_3,int param_4,int param_5,char *param_6,
                 uint param_7,int param_8,float param_9,int *param_10,int *param_11,int *param_12)

{
  uint uVar1;
  byte *pbVar2;
  double dVar3;
  int *piVar4;
  int *piVar5;
  int *piVar6;
  size_t sVar7;
  char *pcVar8;
  undefined4 uVar9;
  int iVar10;
  byte *pbVar11;
  int iVar12;
  uint uVar13;
  uint uVar14;
  uint uVar15;
  uint uVar16;
  uint uVar17;
  int iVar18;
  int *piVar19;
  int iVar20;
  uint uVar21;
  uint uVar22;
  int iVar23;
  undefined4 uVar24;
  undefined4 *puVar25;
  int iVar26;
  int *piVar27;
  int iVar28;
  int iVar29;
  int iVar30;
  int iVar31;
  int iVar32;
  int iVar33;
  int iVar34;
  int iVar35;
  uint uVar36;
  int iVar37;
  uint uVar38;
  uint uVar39;
  int iVar40;
  byte *pbVar41;
  int local_518;
  int local_514;
  int local_508;
  int local_504;
  int local_500;
  int local_4fc;
  int local_4c4;
  int local_4b8;
  int local_4ac;
  int local_4a8;
  int local_4a4;
  int local_47c;
  int local_478;
  int local_474;
  char local_470 [4];
  uint local_46c;
  undefined4 local_468;
  int local_464;
  int *local_460;
  int local_45c;
  int local_458;
  undefined4 local_454;
  void *local_450;
  uint local_44c;
  uint local_448;
  undefined4 local_444;
  uint local_440;
  uint local_43c;
  int local_434;
  char acStack_42c [1024];
  int local_2c;
  
  piVar6 = param_12;
  piVar5 = param_11;
  piVar4 = param_10;
  uVar21 = param_7;
  pcVar8 = param_6;
  dVar3 = DAT_000436e8;
  piVar19 = *(int **)(DAT_000436f8 + 0x43456);
  local_2c = *piVar19;
  *param_10 = -1;
  *param_11 = -1;
  *param_12 = -1;
  uVar24 = *param_1;
  if ((int)((uint)((double)param_9 < dVar3) << 0x1f) < 0) {
    local_4fc = (int)(longlong)((1.0 - (double)param_9) * DAT_000436f0);
  }
  else {
    local_4fc = 0;
  }
  local_47c = param_4;
  local_478 = param_3;
  local_474 = param_2;
  FUN_000429f8(param_1,&local_46c,&local_468,&local_464);
  puVar25 = param_1 + 1;
  FUN_0003b8ac(param_1,&local_474,&local_478,&local_47c,&param_5,local_46c,local_468);
  if (param_1[4] == 0) {
    puVar25 = param_1 + 6;
    FUN_0004233c(param_1,puVar25,local_474,local_478,(local_47c - local_474) + 1,
                 (param_5 - local_478) + 1);
  }
  if (puVar25[3] != 0) {
    FUN_0003b3ac(puVar25);
    local_464 = puVar25[2];
    iVar26 = puVar25[3];
    iVar20 = DAT_000436fc + 0x4352a + local_464 * 0x20;
    uVar14 = (*(uint *)(iVar20 + 100) & uVar21) >> (*(uint *)(iVar20 + 0x70) & 0xff);
    uVar15 = (*(uint *)(iVar20 + 0x68) & uVar21) >> (*(uint *)(iVar20 + 0x74) & 0xff);
    uVar21 = (uVar21 & *(uint *)(iVar20 + 0x6c)) >> (*(uint *)(iVar20 + 0x78) & 0xff);
    if (param_1[0x37] != 0) {
      memset(acStack_42c,0,0x400);
      sVar7 = strlen(pcVar8);
      memcpy(acStack_42c,pcVar8,sVar7 + 1);
      local_470[0] = '|';
      local_470[1] = '\0';
      pcVar8 = strtok(acStack_42c,local_470);
      local_4b8 = 1;
      while (pcVar8 != (char *)0x0) {
        local_45c = 0;
        local_458 = 0;
        local_454 = 0;
        iVar20 = FUN_0005141c(uVar24,pcVar8,&local_45c);
        if (iVar20 == 0) {
          uVar9 = FUN_0003ac9a(param_1[0x37],pcVar8);
          iVar20 = FUN_0003a672(param_1[0x37],param_1[0x38],param_1[0x39],uVar9);
        }
        else {
          iVar20 = local_458 - local_45c;
          uVar9 = (**(code **)(*(int *)param_1[0x37] + 0x2c0))((int *)param_1[0x37],iVar20);
          (**(code **)(*(int *)param_1[0x37] + 0x340))
                    ((int *)param_1[0x37],uVar9,0,iVar20,local_45c);
          iVar20 = FUN_0003a672(param_1[0x37],param_1[0x38],param_1[0x3a],uVar9,0,iVar20);
        }
        FUN_00035280(param_1[0x37],uVar9);
        if (iVar20 == 0) {
LAB_00043644:
          pcVar8 = strtok((char *)0x0,local_470);
        }
        else {
          AndroidBitmap_getInfo(param_1[0x37],iVar20,&local_440);
          if (local_434 != 1) {
            FUN_00035280(param_1[0x37],iVar20);
            goto LAB_00043644;
          }
          local_460 = (int *)0x0;
          AndroidBitmap_lockPixels(param_1[0x37],iVar20,&local_460);
          uVar38 = local_43c;
          uVar16 = local_440;
          piVar27 = local_460;
          if (local_460 == (int *)0x0) {
            FUN_00035280(param_1[0x37],iVar20);
            goto LAB_00043644;
          }
          uVar22 = 1 - local_440;
          if (1 < local_440) {
            uVar22 = 0;
          }
          if (local_43c == 0) {
            uVar22 = uVar22 | 1;
          }
          if (uVar22 == 0) {
            local_450 = malloc(local_43c * local_440 * 4);
            local_44c = uVar16;
            local_448 = uVar38;
          }
          if (local_450 != (void *)0x0) {
            local_444 = 0xffffffff;
            for (uVar16 = 0; uVar16 < local_44c * local_448; uVar16 = uVar16 + 1) {
              if (*piVar27 == 0) {
                local_444 = 0;
              }
              *(int *)((int)local_450 + uVar16 * 4) = *piVar27;
              piVar27 = piVar27 + 1;
            }
          }
          AndroidBitmap_unlockPixels(param_1[0x37],iVar20);
          if (local_450 == (void *)0x0) {
            FUN_00035280(param_1[0x37],iVar20);
          }
          else {
            FUN_0003b310(&local_450);
            if ((1 < local_44c) || (1 < local_448)) {
              iVar29 = local_47c - local_44c;
              iVar37 = iVar29 + 1;
              local_508 = local_474;
              if (local_474 <= iVar37) {
                iVar12 = (param_5 - local_448) + 1;
                local_514 = local_478;
                if (local_478 <= iVar12) {
                  if (param_8 == 0) {
                    iVar28 = iVar26 + (local_46c * local_478 + local_474) * 4;
                    iVar29 = local_474;
                    iVar18 = iVar28;
LAB_0004384c:
                    pbVar41 = (byte *)((int)local_450 + -4);
                    iVar10 = iVar28;
                    for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                      uVar22 = 0;
                      pbVar11 = pbVar41;
                      for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                        pbVar2 = pbVar11 + 4;
                        if (*(int *)pbVar2 != 0) {
                          iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                          if (iVar34 < 0) {
                            iVar34 = -iVar34;
                          }
                          iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                          if (iVar32 < 0) {
                            iVar32 = -iVar32;
                          }
                          iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                          if (iVar30 < 0) {
                            iVar30 = -iVar30;
                          }
                          if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                              ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                            iVar29 = iVar29 + 1;
                            iVar28 = iVar28 + 4;
                            if (iVar29 <= iVar37) goto LAB_0004384c;
                            local_514 = local_514 + 1;
                            iVar28 = iVar18 + local_46c * 4;
                            iVar29 = local_474;
                            iVar18 = iVar28;
                            if (local_514 <= iVar12) goto LAB_0004384c;
                            goto LAB_00044606;
                          }
                        }
                        uVar22 = uVar22 + 4;
                        pbVar11 = pbVar2;
                      }
                      pbVar41 = pbVar41 + local_44c * 4;
                      iVar10 = iVar10 + local_46c * 4;
                    }
LAB_00044110:
                    *piVar4 = iVar29;
                    *piVar5 = local_514;
LAB_00043eb2:
                    *piVar6 = local_4b8 + -1;
                  }
                  else {
                    if (param_8 == 1) {
                      uVar38 = iVar37 - local_474;
                      uVar22 = iVar12 - local_478;
                      uVar16 = uVar22;
                      if ((int)uVar22 < (int)uVar38) {
                        uVar16 = uVar38;
                      }
                      uVar17 = DAT_00043b50 & uVar16;
                      if ((int)uVar17 < 0) {
                        uVar17 = (uVar17 - 1 | 0xfffffffe) + 1;
                      }
                      iVar28 = local_478 + (int)(uVar22 + 1) / 2;
                      iVar29 = local_474 + (int)(uVar38 + 1) / 2;
                      local_500 = iVar26 + (local_46c * iVar28 + iVar29) * 4;
                      iVar10 = local_44c * 4;
                      iVar18 = local_46c * 4;
                      local_4a4 = (iVar28 * local_46c * 0x3fffffff + local_46c * iVar28) * 4;
                      local_518 = iVar28;
                      local_504 = iVar29;
                      local_4ac = local_500;
                      local_4a8 = local_500;
                      for (local_4c4 = 0; local_4c4 <= (int)((int)uVar16 / 2 + uVar17);
                          local_4c4 = local_4c4 + 1) {
                        iVar32 = local_4a8;
                        for (iVar34 = local_504; iVar34 <= local_4c4 + iVar29; iVar34 = iVar34 + 1)
                        {
                          if (iVar34 <= iVar37 && local_474 <= iVar34) {
                            if (iVar28 <= iVar12 && local_478 <= iVar28) {
                              pbVar41 = (byte *)((int)local_450 + -4);
                              iVar30 = iVar32 + local_4a4;
                              for (uVar38 = 0; uVar38 != local_448; uVar38 = uVar38 + 1) {
                                uVar13 = 0;
                                pbVar11 = pbVar41;
                                for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                  pbVar2 = pbVar11 + 4;
                                  if (*(int *)pbVar2 != 0) {
                                    iVar23 = (uint)*(byte *)(iVar30 + uVar13) - (uint)*pbVar2;
                                    if (iVar23 < 0) {
                                      iVar23 = -iVar23;
                                    }
                                    iVar33 = (uint)*(byte *)(iVar30 + uVar13 + 1) - (uint)pbVar11[5]
                                    ;
                                    if (iVar33 < 0) {
                                      iVar33 = -iVar33;
                                    }
                                    iVar35 = (uint)*(byte *)(iVar30 + uVar13 + 2) - (uint)pbVar11[6]
                                    ;
                                    if (iVar35 < 0) {
                                      iVar35 = -iVar35;
                                    }
                                    if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar23) ||
                                        ((int)uVar21 < iVar35)) &&
                                       (local_4fc < iVar33 + iVar23 + iVar35)) goto LAB_00043a40;
                                  }
                                  uVar13 = uVar13 + 4;
                                  pbVar11 = pbVar2;
                                }
                                iVar30 = iVar30 + iVar18;
                                pbVar41 = pbVar41 + iVar10;
                              }
                              *piVar4 = iVar34;
                              *piVar5 = iVar28;
                              goto LAB_0004449a;
                            }
LAB_00043a40:
                            if (local_518 <= iVar12 && local_478 <= local_518) {
                              pbVar41 = (byte *)((int)local_450 + -4);
                              iVar30 = iVar32;
                              for (uVar38 = 0; uVar38 != local_448; uVar38 = uVar38 + 1) {
                                uVar13 = 0;
                                pbVar11 = pbVar41;
                                for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                  pbVar2 = pbVar11 + 4;
                                  if (*(int *)pbVar2 != 0) {
                                    iVar23 = (uint)*(byte *)(iVar30 + uVar13) - (uint)*pbVar2;
                                    if (iVar23 < 0) {
                                      iVar23 = -iVar23;
                                    }
                                    iVar33 = (uint)*(byte *)(iVar30 + uVar13 + 1) - (uint)pbVar11[5]
                                    ;
                                    if (iVar33 < 0) {
                                      iVar33 = -iVar33;
                                    }
                                    iVar35 = (uint)*(byte *)(iVar30 + uVar13 + 2) - (uint)pbVar11[6]
                                    ;
                                    if (iVar35 < 0) {
                                      iVar35 = -iVar35;
                                    }
                                    if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar23) ||
                                        ((int)uVar21 < iVar35)) &&
                                       (local_4fc < iVar33 + iVar23 + iVar35)) goto LAB_00043b2c;
                                  }
                                  uVar13 = uVar13 + 4;
                                  pbVar11 = pbVar2;
                                }
                                iVar30 = iVar30 + iVar18;
                                pbVar41 = pbVar41 + iVar10;
                              }
                              *piVar4 = iVar34;
                              *piVar5 = local_518;
                              goto LAB_0004449a;
                            }
                          }
LAB_00043b2c:
                          iVar32 = iVar32 + 4;
                        }
                        iVar32 = local_500;
                        iVar30 = local_4ac;
                        for (iVar34 = iVar28; iVar34 <= local_518; iVar34 = iVar34 + 1) {
                          if ((local_504 <= iVar37 && local_474 <= local_504) &&
                             (iVar34 <= iVar12 && local_478 <= iVar34)) {
                            iVar23 = iVar30;
                            pbVar41 = (byte *)((int)local_450 + -4);
                            for (uVar38 = 0; iVar33 = local_504, uVar38 != local_448;
                                uVar38 = uVar38 + 1) {
                              uVar13 = 0;
                              pbVar11 = pbVar41;
                              for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                pbVar2 = pbVar11 + 4;
                                if (*(int *)pbVar2 != 0) {
                                  uVar39 = (uint)*(byte *)(iVar23 + uVar13) - (uint)*pbVar2;
                                  iVar33 = (uint)*(byte *)(iVar23 + uVar13 + 1) - (uint)pbVar11[5];
                                  if (iVar33 < 0) {
                                    iVar33 = -iVar33;
                                  }
                                  uVar36 = (uint)*(byte *)(iVar23 + uVar13 + 2) - (uint)pbVar11[6];
                                  uVar1 = (int)uVar39 >> 0x1f;
                                  iVar35 = (uVar39 ^ uVar1) - uVar1;
                                  uVar39 = (int)uVar36 >> 0x1f;
                                  iVar40 = (uVar36 ^ uVar39) - uVar39;
                                  if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar35) ||
                                      ((int)uVar21 < iVar40)) &&
                                     (local_4fc < iVar33 + iVar35 + iVar40)) {
                                    uVar38 = 0;
                                    iVar23 = iVar32;
                                    pbVar41 = (byte *)((int)local_450 + -4);
                                    goto LAB_00043d26;
                                  }
                                }
                                uVar13 = uVar13 + 4;
                                pbVar11 = pbVar2;
                              }
                              pbVar41 = pbVar41 + iVar10;
                              iVar23 = iVar23 + iVar18;
                            }
LAB_00043d32:
                            *piVar4 = iVar33;
                            *piVar5 = iVar34;
                            goto LAB_0004449a;
                          }
LAB_00043d3c:
                          iVar32 = iVar32 + iVar18;
                          iVar30 = iVar30 + iVar18;
                        }
                        local_518 = local_518 + 1;
                        iVar28 = iVar28 + -1;
                        local_504 = local_504 + -1;
                        local_500 = local_500 + local_46c * -4 + 4;
                        local_4ac = local_4ac + ~local_46c * 4;
                        local_4a8 = local_4a8 + (local_46c - 1) * 4;
                        local_4a4 = local_4a4 + local_46c * -8;
                      }
                      goto LAB_00044606;
                    }
                    iVar18 = iVar37;
                    iVar28 = iVar12;
                    if (param_8 == 2) {
                      iVar12 = iVar26 + (local_46c * iVar12 + iVar37) * 4;
                      iVar29 = iVar12;
LAB_00043eca:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar12;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            uVar13 = (int)uVar17 >> 0x1f;
                            iVar32 = (uVar17 ^ uVar13) - uVar13;
                            uVar17 = (int)uVar39 >> 0x1f;
                            iVar30 = (uVar39 ^ uVar17) - uVar17;
                            if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30)) {
                              iVar18 = iVar18 + -1;
                              iVar12 = iVar12 + -4;
                              if (local_474 <= iVar18) goto LAB_00043eca;
                              iVar28 = iVar28 + -1;
                              iVar12 = iVar29 + local_46c * -4;
                              iVar18 = iVar37;
                              iVar29 = iVar12;
                              if (iVar28 < local_478) goto LAB_00044606;
                              goto LAB_00043eca;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
LAB_00043ea6:
                      *piVar4 = iVar18;
                      *piVar5 = iVar28;
                      goto LAB_00043eb2;
                    }
                    if (param_8 == 3) {
                      iVar12 = iVar26 + (local_46c * iVar12 + local_474) * 4;
                      iVar18 = local_474;
                      iVar29 = iVar12;
LAB_00044002:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar12;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            uVar13 = (int)uVar17 >> 0x1f;
                            iVar32 = (uVar17 ^ uVar13) - uVar13;
                            uVar17 = (int)uVar39 >> 0x1f;
                            iVar30 = (uVar39 ^ uVar17) - uVar17;
                            if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30)) {
                              iVar18 = iVar18 + 1;
                              iVar12 = iVar12 + 4;
                              if (iVar18 <= iVar37) goto LAB_00044002;
                              iVar28 = iVar28 + -1;
                              iVar12 = iVar29 + local_46c * -4;
                              iVar18 = local_474;
                              iVar29 = iVar12;
                              if (local_478 <= iVar28) goto LAB_00044002;
                              goto LAB_00044606;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
                      goto LAB_00043ea6;
                    }
                    if (param_8 == 4) {
                      iVar28 = iVar26 + (local_46c * local_478 + iVar29 + 1) * 4;
                      iVar29 = iVar37;
                      iVar18 = iVar28;
LAB_0004412c:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar28;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar32 < 0) {
                              iVar32 = -iVar32;
                            }
                            iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            if (iVar30 < 0) {
                              iVar30 = -iVar30;
                            }
                            if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                              iVar29 = iVar29 + -1;
                              iVar28 = iVar28 + -4;
                              if (local_474 <= iVar29) goto LAB_0004412c;
                              local_514 = local_514 + 1;
                              iVar28 = iVar18 + local_46c * 4;
                              iVar29 = iVar37;
                              iVar18 = iVar28;
                              if (iVar12 < local_514) goto LAB_00044606;
                              goto LAB_0004412c;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
                      goto LAB_00044110;
                    }
                    if (param_8 != 5) {
                      if (param_8 == 6) {
                        iVar37 = iVar26 + (local_46c * local_478 + iVar29 + 1) * 4;
                        iVar28 = local_478;
                        iVar29 = iVar37;
LAB_00044380:
                        pbVar41 = (byte *)((int)local_450 + -4);
                        iVar10 = iVar37;
                        for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                          uVar22 = 0;
                          pbVar11 = pbVar41;
                          for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                            pbVar2 = pbVar11 + 4;
                            if (*(int *)pbVar2 != 0) {
                              uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                              iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                              if (iVar34 < 0) {
                                iVar34 = -iVar34;
                              }
                              uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                              uVar13 = (int)uVar17 >> 0x1f;
                              iVar32 = (uVar17 ^ uVar13) - uVar13;
                              uVar17 = (int)uVar39 >> 0x1f;
                              iVar30 = (uVar39 ^ uVar17) - uVar17;
                              if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                  ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30))
                              {
                                iVar28 = iVar28 + 1;
                                iVar37 = iVar37 + local_46c * 4;
                                if (iVar28 <= iVar12) goto LAB_00044380;
                                iVar18 = iVar18 + -1;
                                iVar37 = iVar29 + -4;
                                iVar28 = local_478;
                                iVar29 = iVar37;
                                if (local_474 <= iVar18) goto LAB_00044380;
                                goto LAB_00044606;
                              }
                            }
                            uVar22 = uVar22 + 4;
                            pbVar11 = pbVar2;
                          }
                          pbVar41 = pbVar41 + local_44c * 4;
                          iVar10 = iVar10 + local_46c * 4;
                        }
                      }
                      else {
                        if (param_8 == 7) {
                          iVar28 = iVar26 + (local_46c * iVar12 + local_474) * 4;
                          iVar29 = iVar12;
                          iVar18 = iVar28;
LAB_000444b2:
                          pbVar41 = (byte *)((int)local_450 + -4);
                          iVar10 = iVar28;
                          for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                            uVar22 = 0;
                            pbVar11 = pbVar41;
                            for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                              pbVar2 = pbVar11 + 4;
                              if (*(int *)pbVar2 != 0) {
                                iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                                if (iVar34 < 0) {
                                  iVar34 = -iVar34;
                                }
                                iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                                if (iVar32 < 0) {
                                  iVar32 = -iVar32;
                                }
                                iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                                if (iVar30 < 0) {
                                  iVar30 = -iVar30;
                                }
                                if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                                    ((int)uVar21 < iVar30)) &&
                                   (local_4fc < iVar32 + iVar34 + iVar30)) {
                                  iVar29 = iVar29 + -1;
                                  iVar28 = iVar28 + local_46c * -4;
                                  if (local_478 <= iVar29) goto LAB_000444b2;
                                  iVar28 = iVar18 + 4;
                                  local_508 = local_508 + 1;
                                  iVar29 = iVar12;
                                  iVar18 = iVar28;
                                  if (iVar37 < local_508) goto LAB_00044606;
                                  goto LAB_000444b2;
                                }
                              }
                              uVar22 = uVar22 + 4;
                              pbVar11 = pbVar2;
                            }
                            pbVar41 = pbVar41 + local_44c * 4;
                            iVar10 = iVar10 + local_46c * 4;
                          }
                          goto LAB_00044490;
                        }
                        if (param_8 != 8) goto LAB_00044606;
                        iVar37 = iVar26 + (local_46c * iVar12 + iVar37) * 4;
                        iVar29 = iVar37;
LAB_000445e8:
                        pbVar41 = (byte *)((int)local_450 + -4);
                        iVar10 = iVar37;
                        for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                          uVar22 = 0;
                          pbVar11 = pbVar41;
                          for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                            pbVar2 = pbVar11 + 4;
                            if (*(int *)pbVar2 != 0) {
                              uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                              iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                              if (iVar34 < 0) {
                                iVar34 = -iVar34;
                              }
                              uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                              uVar13 = (int)uVar17 >> 0x1f;
                              iVar32 = (uVar17 ^ uVar13) - uVar13;
                              uVar17 = (int)uVar39 >> 0x1f;
                              iVar30 = (uVar39 ^ uVar17) - uVar17;
                              if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                  ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30))
                              {
                                iVar28 = iVar28 + -1;
                                iVar37 = iVar37 + local_46c * -4;
                                if (local_478 <= iVar28) goto LAB_000445e8;
                                iVar18 = iVar18 + -1;
                                iVar37 = iVar29 + -4;
                                iVar28 = iVar12;
                                iVar29 = iVar37;
                                if (iVar18 < local_474) goto LAB_00044606;
                                goto LAB_000445e8;
                              }
                            }
                            uVar22 = uVar22 + 4;
                            pbVar11 = pbVar2;
                          }
                          pbVar41 = pbVar41 + local_44c * 4;
                          iVar10 = iVar10 + local_46c * 4;
                        }
                      }
                      goto LAB_00043ea6;
                    }
                    iVar28 = iVar26 + (local_46c * local_478 + local_474) * 4;
                    iVar29 = local_478;
                    iVar18 = iVar28;
LAB_00044254:
                    pbVar41 = (byte *)((int)local_450 + -4);
                    iVar10 = iVar28;
                    for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                      uVar22 = 0;
                      pbVar11 = pbVar41;
                      for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                        pbVar2 = pbVar11 + 4;
                        if (*(int *)pbVar2 != 0) {
                          iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                          if (iVar34 < 0) {
                            iVar34 = -iVar34;
                          }
                          iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                          if (iVar32 < 0) {
                            iVar32 = -iVar32;
                          }
                          iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                          if (iVar30 < 0) {
                            iVar30 = -iVar30;
                          }
                          if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                              ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                            iVar29 = iVar29 + 1;
                            iVar28 = iVar28 + local_46c * 4;
                            if (iVar29 <= iVar12) goto LAB_00044254;
                            iVar28 = iVar18 + 4;
                            local_508 = local_508 + 1;
                            iVar29 = local_478;
                            iVar18 = iVar28;
                            if (local_508 <= iVar37) goto LAB_00044254;
                            goto LAB_00044606;
                          }
                        }
                        uVar22 = uVar22 + 4;
                        pbVar11 = pbVar2;
                      }
                      pbVar41 = pbVar41 + local_44c * 4;
                      iVar10 = iVar10 + local_46c * 4;
                    }
LAB_00044490:
                    *piVar4 = local_508;
                    *piVar5 = iVar29;
LAB_0004449a:
                    *piVar6 = local_4b8 + -1;
                  }
                  if (local_450 != (void *)0x0) {
                    free(local_450);
                  }
                  FUN_0003bd5a(&local_45c);
                  FUN_00035280(param_1[0x37],iVar20);
                  break;
                }
              }
            }
LAB_00044606:
            FUN_00035280(param_1[0x37],iVar20);
          }
          pcVar8 = strtok((char *)0x0,local_470);
          if (local_450 != (void *)0x0) {
            free(local_450);
          }
        }
        FUN_0003bd5a(&local_45c);
        local_4b8 = local_4b8 + 1;
      }
    }
  }
  if (local_2c == *piVar19) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
LAB_00043d26:
  iVar33 = local_4c4 + iVar29;
  if (uVar38 == local_448) goto LAB_00043d32;
  iVar33 = 0;
  pbVar11 = pbVar41;
  for (uVar22 = 0; uVar22 != local_44c; uVar22 = uVar22 + 1) {
    pbVar2 = pbVar11 + 4;
    if (*(int *)pbVar2 != 0) {
      iVar35 = (uint)*(byte *)(iVar23 + iVar33) - (uint)*pbVar2;
      if (iVar35 < 0) {
        iVar35 = -iVar35;
      }
      iVar40 = (uint)*(byte *)(iVar23 + iVar33 + 1) - (uint)pbVar11[5];
      if (iVar40 < 0) {
        iVar40 = -iVar40;
      }
      iVar31 = (uint)*(byte *)(iVar23 + iVar33 + 2) - (uint)pbVar11[6];
      if (iVar31 < 0) {
        iVar31 = -iVar31;
      }
      if ((((int)uVar15 < iVar40 || (int)uVar14 < iVar35) || ((int)uVar21 < iVar31)) &&
         (local_4fc < iVar40 + iVar35 + iVar31)) goto LAB_00043d3c;
    }
    iVar33 = iVar33 + 4;
    pbVar11 = pbVar2;
  }
  uVar38 = uVar38 + 1;
  pbVar41 = pbVar41 + iVar10;
  iVar23 = iVar23 + iVar18;
  goto LAB_00043d26;
}



/* ============================================================ */
/* Target 0x438c4 */
/* Ghidra name: FUN_00043438 */
/* Entry: 00043438 */

void FUN_00043438(undefined4 *param_1,int param_2,int param_3,int param_4,int param_5,char *param_6,
                 uint param_7,int param_8,float param_9,int *param_10,int *param_11,int *param_12)

{
  uint uVar1;
  byte *pbVar2;
  double dVar3;
  int *piVar4;
  int *piVar5;
  int *piVar6;
  size_t sVar7;
  char *pcVar8;
  undefined4 uVar9;
  int iVar10;
  byte *pbVar11;
  int iVar12;
  uint uVar13;
  uint uVar14;
  uint uVar15;
  uint uVar16;
  uint uVar17;
  int iVar18;
  int *piVar19;
  int iVar20;
  uint uVar21;
  uint uVar22;
  int iVar23;
  undefined4 uVar24;
  undefined4 *puVar25;
  int iVar26;
  int *piVar27;
  int iVar28;
  int iVar29;
  int iVar30;
  int iVar31;
  int iVar32;
  int iVar33;
  int iVar34;
  int iVar35;
  uint uVar36;
  int iVar37;
  uint uVar38;
  uint uVar39;
  int iVar40;
  byte *pbVar41;
  int local_518;
  int local_514;
  int local_508;
  int local_504;
  int local_500;
  int local_4fc;
  int local_4c4;
  int local_4b8;
  int local_4ac;
  int local_4a8;
  int local_4a4;
  int local_47c;
  int local_478;
  int local_474;
  char local_470 [4];
  uint local_46c;
  undefined4 local_468;
  int local_464;
  int *local_460;
  int local_45c;
  int local_458;
  undefined4 local_454;
  void *local_450;
  uint local_44c;
  uint local_448;
  undefined4 local_444;
  uint local_440;
  uint local_43c;
  int local_434;
  char acStack_42c [1024];
  int local_2c;
  
  piVar6 = param_12;
  piVar5 = param_11;
  piVar4 = param_10;
  uVar21 = param_7;
  pcVar8 = param_6;
  dVar3 = DAT_000436e8;
  piVar19 = *(int **)(DAT_000436f8 + 0x43456);
  local_2c = *piVar19;
  *param_10 = -1;
  *param_11 = -1;
  *param_12 = -1;
  uVar24 = *param_1;
  if ((int)((uint)((double)param_9 < dVar3) << 0x1f) < 0) {
    local_4fc = (int)(longlong)((1.0 - (double)param_9) * DAT_000436f0);
  }
  else {
    local_4fc = 0;
  }
  local_47c = param_4;
  local_478 = param_3;
  local_474 = param_2;
  FUN_000429f8(param_1,&local_46c,&local_468,&local_464);
  puVar25 = param_1 + 1;
  FUN_0003b8ac(param_1,&local_474,&local_478,&local_47c,&param_5,local_46c,local_468);
  if (param_1[4] == 0) {
    puVar25 = param_1 + 6;
    FUN_0004233c(param_1,puVar25,local_474,local_478,(local_47c - local_474) + 1,
                 (param_5 - local_478) + 1);
  }
  if (puVar25[3] != 0) {
    FUN_0003b3ac(puVar25);
    local_464 = puVar25[2];
    iVar26 = puVar25[3];
    iVar20 = DAT_000436fc + 0x4352a + local_464 * 0x20;
    uVar14 = (*(uint *)(iVar20 + 100) & uVar21) >> (*(uint *)(iVar20 + 0x70) & 0xff);
    uVar15 = (*(uint *)(iVar20 + 0x68) & uVar21) >> (*(uint *)(iVar20 + 0x74) & 0xff);
    uVar21 = (uVar21 & *(uint *)(iVar20 + 0x6c)) >> (*(uint *)(iVar20 + 0x78) & 0xff);
    if (param_1[0x37] != 0) {
      memset(acStack_42c,0,0x400);
      sVar7 = strlen(pcVar8);
      memcpy(acStack_42c,pcVar8,sVar7 + 1);
      local_470[0] = '|';
      local_470[1] = '\0';
      pcVar8 = strtok(acStack_42c,local_470);
      local_4b8 = 1;
      while (pcVar8 != (char *)0x0) {
        local_45c = 0;
        local_458 = 0;
        local_454 = 0;
        iVar20 = FUN_0005141c(uVar24,pcVar8,&local_45c);
        if (iVar20 == 0) {
          uVar9 = FUN_0003ac9a(param_1[0x37],pcVar8);
          iVar20 = FUN_0003a672(param_1[0x37],param_1[0x38],param_1[0x39],uVar9);
        }
        else {
          iVar20 = local_458 - local_45c;
          uVar9 = (**(code **)(*(int *)param_1[0x37] + 0x2c0))((int *)param_1[0x37],iVar20);
          (**(code **)(*(int *)param_1[0x37] + 0x340))
                    ((int *)param_1[0x37],uVar9,0,iVar20,local_45c);
          iVar20 = FUN_0003a672(param_1[0x37],param_1[0x38],param_1[0x3a],uVar9,0,iVar20);
        }
        FUN_00035280(param_1[0x37],uVar9);
        if (iVar20 == 0) {
LAB_00043644:
          pcVar8 = strtok((char *)0x0,local_470);
        }
        else {
          AndroidBitmap_getInfo(param_1[0x37],iVar20,&local_440);
          if (local_434 != 1) {
            FUN_00035280(param_1[0x37],iVar20);
            goto LAB_00043644;
          }
          local_460 = (int *)0x0;
          AndroidBitmap_lockPixels(param_1[0x37],iVar20,&local_460);
          uVar38 = local_43c;
          uVar16 = local_440;
          piVar27 = local_460;
          if (local_460 == (int *)0x0) {
            FUN_00035280(param_1[0x37],iVar20);
            goto LAB_00043644;
          }
          uVar22 = 1 - local_440;
          if (1 < local_440) {
            uVar22 = 0;
          }
          if (local_43c == 0) {
            uVar22 = uVar22 | 1;
          }
          if (uVar22 == 0) {
            local_450 = malloc(local_43c * local_440 * 4);
            local_44c = uVar16;
            local_448 = uVar38;
          }
          if (local_450 != (void *)0x0) {
            local_444 = 0xffffffff;
            for (uVar16 = 0; uVar16 < local_44c * local_448; uVar16 = uVar16 + 1) {
              if (*piVar27 == 0) {
                local_444 = 0;
              }
              *(int *)((int)local_450 + uVar16 * 4) = *piVar27;
              piVar27 = piVar27 + 1;
            }
          }
          AndroidBitmap_unlockPixels(param_1[0x37],iVar20);
          if (local_450 == (void *)0x0) {
            FUN_00035280(param_1[0x37],iVar20);
          }
          else {
            FUN_0003b310(&local_450);
            if ((1 < local_44c) || (1 < local_448)) {
              iVar29 = local_47c - local_44c;
              iVar37 = iVar29 + 1;
              local_508 = local_474;
              if (local_474 <= iVar37) {
                iVar12 = (param_5 - local_448) + 1;
                local_514 = local_478;
                if (local_478 <= iVar12) {
                  if (param_8 == 0) {
                    iVar28 = iVar26 + (local_46c * local_478 + local_474) * 4;
                    iVar29 = local_474;
                    iVar18 = iVar28;
LAB_0004384c:
                    pbVar41 = (byte *)((int)local_450 + -4);
                    iVar10 = iVar28;
                    for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                      uVar22 = 0;
                      pbVar11 = pbVar41;
                      for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                        pbVar2 = pbVar11 + 4;
                        if (*(int *)pbVar2 != 0) {
                          iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                          if (iVar34 < 0) {
                            iVar34 = -iVar34;
                          }
                          iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                          if (iVar32 < 0) {
                            iVar32 = -iVar32;
                          }
                          iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                          if (iVar30 < 0) {
                            iVar30 = -iVar30;
                          }
                          if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                              ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                            iVar29 = iVar29 + 1;
                            iVar28 = iVar28 + 4;
                            if (iVar29 <= iVar37) goto LAB_0004384c;
                            local_514 = local_514 + 1;
                            iVar28 = iVar18 + local_46c * 4;
                            iVar29 = local_474;
                            iVar18 = iVar28;
                            if (local_514 <= iVar12) goto LAB_0004384c;
                            goto LAB_00044606;
                          }
                        }
                        uVar22 = uVar22 + 4;
                        pbVar11 = pbVar2;
                      }
                      pbVar41 = pbVar41 + local_44c * 4;
                      iVar10 = iVar10 + local_46c * 4;
                    }
LAB_00044110:
                    *piVar4 = iVar29;
                    *piVar5 = local_514;
LAB_00043eb2:
                    *piVar6 = local_4b8 + -1;
                  }
                  else {
                    if (param_8 == 1) {
                      uVar38 = iVar37 - local_474;
                      uVar22 = iVar12 - local_478;
                      uVar16 = uVar22;
                      if ((int)uVar22 < (int)uVar38) {
                        uVar16 = uVar38;
                      }
                      uVar17 = DAT_00043b50 & uVar16;
                      if ((int)uVar17 < 0) {
                        uVar17 = (uVar17 - 1 | 0xfffffffe) + 1;
                      }
                      iVar28 = local_478 + (int)(uVar22 + 1) / 2;
                      iVar29 = local_474 + (int)(uVar38 + 1) / 2;
                      local_500 = iVar26 + (local_46c * iVar28 + iVar29) * 4;
                      iVar10 = local_44c * 4;
                      iVar18 = local_46c * 4;
                      local_4a4 = (iVar28 * local_46c * 0x3fffffff + local_46c * iVar28) * 4;
                      local_518 = iVar28;
                      local_504 = iVar29;
                      local_4ac = local_500;
                      local_4a8 = local_500;
                      for (local_4c4 = 0; local_4c4 <= (int)((int)uVar16 / 2 + uVar17);
                          local_4c4 = local_4c4 + 1) {
                        iVar32 = local_4a8;
                        for (iVar34 = local_504; iVar34 <= local_4c4 + iVar29; iVar34 = iVar34 + 1)
                        {
                          if (iVar34 <= iVar37 && local_474 <= iVar34) {
                            if (iVar28 <= iVar12 && local_478 <= iVar28) {
                              pbVar41 = (byte *)((int)local_450 + -4);
                              iVar30 = iVar32 + local_4a4;
                              for (uVar38 = 0; uVar38 != local_448; uVar38 = uVar38 + 1) {
                                uVar13 = 0;
                                pbVar11 = pbVar41;
                                for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                  pbVar2 = pbVar11 + 4;
                                  if (*(int *)pbVar2 != 0) {
                                    iVar23 = (uint)*(byte *)(iVar30 + uVar13) - (uint)*pbVar2;
                                    if (iVar23 < 0) {
                                      iVar23 = -iVar23;
                                    }
                                    iVar33 = (uint)*(byte *)(iVar30 + uVar13 + 1) - (uint)pbVar11[5]
                                    ;
                                    if (iVar33 < 0) {
                                      iVar33 = -iVar33;
                                    }
                                    iVar35 = (uint)*(byte *)(iVar30 + uVar13 + 2) - (uint)pbVar11[6]
                                    ;
                                    if (iVar35 < 0) {
                                      iVar35 = -iVar35;
                                    }
                                    if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar23) ||
                                        ((int)uVar21 < iVar35)) &&
                                       (local_4fc < iVar33 + iVar23 + iVar35)) goto LAB_00043a40;
                                  }
                                  uVar13 = uVar13 + 4;
                                  pbVar11 = pbVar2;
                                }
                                iVar30 = iVar30 + iVar18;
                                pbVar41 = pbVar41 + iVar10;
                              }
                              *piVar4 = iVar34;
                              *piVar5 = iVar28;
                              goto LAB_0004449a;
                            }
LAB_00043a40:
                            if (local_518 <= iVar12 && local_478 <= local_518) {
                              pbVar41 = (byte *)((int)local_450 + -4);
                              iVar30 = iVar32;
                              for (uVar38 = 0; uVar38 != local_448; uVar38 = uVar38 + 1) {
                                uVar13 = 0;
                                pbVar11 = pbVar41;
                                for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                  pbVar2 = pbVar11 + 4;
                                  if (*(int *)pbVar2 != 0) {
                                    iVar23 = (uint)*(byte *)(iVar30 + uVar13) - (uint)*pbVar2;
                                    if (iVar23 < 0) {
                                      iVar23 = -iVar23;
                                    }
                                    iVar33 = (uint)*(byte *)(iVar30 + uVar13 + 1) - (uint)pbVar11[5]
                                    ;
                                    if (iVar33 < 0) {
                                      iVar33 = -iVar33;
                                    }
                                    iVar35 = (uint)*(byte *)(iVar30 + uVar13 + 2) - (uint)pbVar11[6]
                                    ;
                                    if (iVar35 < 0) {
                                      iVar35 = -iVar35;
                                    }
                                    if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar23) ||
                                        ((int)uVar21 < iVar35)) &&
                                       (local_4fc < iVar33 + iVar23 + iVar35)) goto LAB_00043b2c;
                                  }
                                  uVar13 = uVar13 + 4;
                                  pbVar11 = pbVar2;
                                }
                                iVar30 = iVar30 + iVar18;
                                pbVar41 = pbVar41 + iVar10;
                              }
                              *piVar4 = iVar34;
                              *piVar5 = local_518;
                              goto LAB_0004449a;
                            }
                          }
LAB_00043b2c:
                          iVar32 = iVar32 + 4;
                        }
                        iVar32 = local_500;
                        iVar30 = local_4ac;
                        for (iVar34 = iVar28; iVar34 <= local_518; iVar34 = iVar34 + 1) {
                          if ((local_504 <= iVar37 && local_474 <= local_504) &&
                             (iVar34 <= iVar12 && local_478 <= iVar34)) {
                            iVar23 = iVar30;
                            pbVar41 = (byte *)((int)local_450 + -4);
                            for (uVar38 = 0; iVar33 = local_504, uVar38 != local_448;
                                uVar38 = uVar38 + 1) {
                              uVar13 = 0;
                              pbVar11 = pbVar41;
                              for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                pbVar2 = pbVar11 + 4;
                                if (*(int *)pbVar2 != 0) {
                                  uVar39 = (uint)*(byte *)(iVar23 + uVar13) - (uint)*pbVar2;
                                  iVar33 = (uint)*(byte *)(iVar23 + uVar13 + 1) - (uint)pbVar11[5];
                                  if (iVar33 < 0) {
                                    iVar33 = -iVar33;
                                  }
                                  uVar36 = (uint)*(byte *)(iVar23 + uVar13 + 2) - (uint)pbVar11[6];
                                  uVar1 = (int)uVar39 >> 0x1f;
                                  iVar35 = (uVar39 ^ uVar1) - uVar1;
                                  uVar39 = (int)uVar36 >> 0x1f;
                                  iVar40 = (uVar36 ^ uVar39) - uVar39;
                                  if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar35) ||
                                      ((int)uVar21 < iVar40)) &&
                                     (local_4fc < iVar33 + iVar35 + iVar40)) {
                                    uVar38 = 0;
                                    iVar23 = iVar32;
                                    pbVar41 = (byte *)((int)local_450 + -4);
                                    goto LAB_00043d26;
                                  }
                                }
                                uVar13 = uVar13 + 4;
                                pbVar11 = pbVar2;
                              }
                              pbVar41 = pbVar41 + iVar10;
                              iVar23 = iVar23 + iVar18;
                            }
LAB_00043d32:
                            *piVar4 = iVar33;
                            *piVar5 = iVar34;
                            goto LAB_0004449a;
                          }
LAB_00043d3c:
                          iVar32 = iVar32 + iVar18;
                          iVar30 = iVar30 + iVar18;
                        }
                        local_518 = local_518 + 1;
                        iVar28 = iVar28 + -1;
                        local_504 = local_504 + -1;
                        local_500 = local_500 + local_46c * -4 + 4;
                        local_4ac = local_4ac + ~local_46c * 4;
                        local_4a8 = local_4a8 + (local_46c - 1) * 4;
                        local_4a4 = local_4a4 + local_46c * -8;
                      }
                      goto LAB_00044606;
                    }
                    iVar18 = iVar37;
                    iVar28 = iVar12;
                    if (param_8 == 2) {
                      iVar12 = iVar26 + (local_46c * iVar12 + iVar37) * 4;
                      iVar29 = iVar12;
LAB_00043eca:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar12;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            uVar13 = (int)uVar17 >> 0x1f;
                            iVar32 = (uVar17 ^ uVar13) - uVar13;
                            uVar17 = (int)uVar39 >> 0x1f;
                            iVar30 = (uVar39 ^ uVar17) - uVar17;
                            if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30)) {
                              iVar18 = iVar18 + -1;
                              iVar12 = iVar12 + -4;
                              if (local_474 <= iVar18) goto LAB_00043eca;
                              iVar28 = iVar28 + -1;
                              iVar12 = iVar29 + local_46c * -4;
                              iVar18 = iVar37;
                              iVar29 = iVar12;
                              if (iVar28 < local_478) goto LAB_00044606;
                              goto LAB_00043eca;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
LAB_00043ea6:
                      *piVar4 = iVar18;
                      *piVar5 = iVar28;
                      goto LAB_00043eb2;
                    }
                    if (param_8 == 3) {
                      iVar12 = iVar26 + (local_46c * iVar12 + local_474) * 4;
                      iVar18 = local_474;
                      iVar29 = iVar12;
LAB_00044002:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar12;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            uVar13 = (int)uVar17 >> 0x1f;
                            iVar32 = (uVar17 ^ uVar13) - uVar13;
                            uVar17 = (int)uVar39 >> 0x1f;
                            iVar30 = (uVar39 ^ uVar17) - uVar17;
                            if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30)) {
                              iVar18 = iVar18 + 1;
                              iVar12 = iVar12 + 4;
                              if (iVar18 <= iVar37) goto LAB_00044002;
                              iVar28 = iVar28 + -1;
                              iVar12 = iVar29 + local_46c * -4;
                              iVar18 = local_474;
                              iVar29 = iVar12;
                              if (local_478 <= iVar28) goto LAB_00044002;
                              goto LAB_00044606;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
                      goto LAB_00043ea6;
                    }
                    if (param_8 == 4) {
                      iVar28 = iVar26 + (local_46c * local_478 + iVar29 + 1) * 4;
                      iVar29 = iVar37;
                      iVar18 = iVar28;
LAB_0004412c:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar28;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar32 < 0) {
                              iVar32 = -iVar32;
                            }
                            iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            if (iVar30 < 0) {
                              iVar30 = -iVar30;
                            }
                            if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                              iVar29 = iVar29 + -1;
                              iVar28 = iVar28 + -4;
                              if (local_474 <= iVar29) goto LAB_0004412c;
                              local_514 = local_514 + 1;
                              iVar28 = iVar18 + local_46c * 4;
                              iVar29 = iVar37;
                              iVar18 = iVar28;
                              if (iVar12 < local_514) goto LAB_00044606;
                              goto LAB_0004412c;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
                      goto LAB_00044110;
                    }
                    if (param_8 != 5) {
                      if (param_8 == 6) {
                        iVar37 = iVar26 + (local_46c * local_478 + iVar29 + 1) * 4;
                        iVar28 = local_478;
                        iVar29 = iVar37;
LAB_00044380:
                        pbVar41 = (byte *)((int)local_450 + -4);
                        iVar10 = iVar37;
                        for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                          uVar22 = 0;
                          pbVar11 = pbVar41;
                          for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                            pbVar2 = pbVar11 + 4;
                            if (*(int *)pbVar2 != 0) {
                              uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                              iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                              if (iVar34 < 0) {
                                iVar34 = -iVar34;
                              }
                              uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                              uVar13 = (int)uVar17 >> 0x1f;
                              iVar32 = (uVar17 ^ uVar13) - uVar13;
                              uVar17 = (int)uVar39 >> 0x1f;
                              iVar30 = (uVar39 ^ uVar17) - uVar17;
                              if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                  ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30))
                              {
                                iVar28 = iVar28 + 1;
                                iVar37 = iVar37 + local_46c * 4;
                                if (iVar28 <= iVar12) goto LAB_00044380;
                                iVar18 = iVar18 + -1;
                                iVar37 = iVar29 + -4;
                                iVar28 = local_478;
                                iVar29 = iVar37;
                                if (local_474 <= iVar18) goto LAB_00044380;
                                goto LAB_00044606;
                              }
                            }
                            uVar22 = uVar22 + 4;
                            pbVar11 = pbVar2;
                          }
                          pbVar41 = pbVar41 + local_44c * 4;
                          iVar10 = iVar10 + local_46c * 4;
                        }
                      }
                      else {
                        if (param_8 == 7) {
                          iVar28 = iVar26 + (local_46c * iVar12 + local_474) * 4;
                          iVar29 = iVar12;
                          iVar18 = iVar28;
LAB_000444b2:
                          pbVar41 = (byte *)((int)local_450 + -4);
                          iVar10 = iVar28;
                          for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                            uVar22 = 0;
                            pbVar11 = pbVar41;
                            for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                              pbVar2 = pbVar11 + 4;
                              if (*(int *)pbVar2 != 0) {
                                iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                                if (iVar34 < 0) {
                                  iVar34 = -iVar34;
                                }
                                iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                                if (iVar32 < 0) {
                                  iVar32 = -iVar32;
                                }
                                iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                                if (iVar30 < 0) {
                                  iVar30 = -iVar30;
                                }
                                if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                                    ((int)uVar21 < iVar30)) &&
                                   (local_4fc < iVar32 + iVar34 + iVar30)) {
                                  iVar29 = iVar29 + -1;
                                  iVar28 = iVar28 + local_46c * -4;
                                  if (local_478 <= iVar29) goto LAB_000444b2;
                                  iVar28 = iVar18 + 4;
                                  local_508 = local_508 + 1;
                                  iVar29 = iVar12;
                                  iVar18 = iVar28;
                                  if (iVar37 < local_508) goto LAB_00044606;
                                  goto LAB_000444b2;
                                }
                              }
                              uVar22 = uVar22 + 4;
                              pbVar11 = pbVar2;
                            }
                            pbVar41 = pbVar41 + local_44c * 4;
                            iVar10 = iVar10 + local_46c * 4;
                          }
                          goto LAB_00044490;
                        }
                        if (param_8 != 8) goto LAB_00044606;
                        iVar37 = iVar26 + (local_46c * iVar12 + iVar37) * 4;
                        iVar29 = iVar37;
LAB_000445e8:
                        pbVar41 = (byte *)((int)local_450 + -4);
                        iVar10 = iVar37;
                        for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                          uVar22 = 0;
                          pbVar11 = pbVar41;
                          for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                            pbVar2 = pbVar11 + 4;
                            if (*(int *)pbVar2 != 0) {
                              uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                              iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                              if (iVar34 < 0) {
                                iVar34 = -iVar34;
                              }
                              uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                              uVar13 = (int)uVar17 >> 0x1f;
                              iVar32 = (uVar17 ^ uVar13) - uVar13;
                              uVar17 = (int)uVar39 >> 0x1f;
                              iVar30 = (uVar39 ^ uVar17) - uVar17;
                              if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                  ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30))
                              {
                                iVar28 = iVar28 + -1;
                                iVar37 = iVar37 + local_46c * -4;
                                if (local_478 <= iVar28) goto LAB_000445e8;
                                iVar18 = iVar18 + -1;
                                iVar37 = iVar29 + -4;
                                iVar28 = iVar12;
                                iVar29 = iVar37;
                                if (iVar18 < local_474) goto LAB_00044606;
                                goto LAB_000445e8;
                              }
                            }
                            uVar22 = uVar22 + 4;
                            pbVar11 = pbVar2;
                          }
                          pbVar41 = pbVar41 + local_44c * 4;
                          iVar10 = iVar10 + local_46c * 4;
                        }
                      }
                      goto LAB_00043ea6;
                    }
                    iVar28 = iVar26 + (local_46c * local_478 + local_474) * 4;
                    iVar29 = local_478;
                    iVar18 = iVar28;
LAB_00044254:
                    pbVar41 = (byte *)((int)local_450 + -4);
                    iVar10 = iVar28;
                    for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                      uVar22 = 0;
                      pbVar11 = pbVar41;
                      for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                        pbVar2 = pbVar11 + 4;
                        if (*(int *)pbVar2 != 0) {
                          iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                          if (iVar34 < 0) {
                            iVar34 = -iVar34;
                          }
                          iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                          if (iVar32 < 0) {
                            iVar32 = -iVar32;
                          }
                          iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                          if (iVar30 < 0) {
                            iVar30 = -iVar30;
                          }
                          if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                              ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                            iVar29 = iVar29 + 1;
                            iVar28 = iVar28 + local_46c * 4;
                            if (iVar29 <= iVar12) goto LAB_00044254;
                            iVar28 = iVar18 + 4;
                            local_508 = local_508 + 1;
                            iVar29 = local_478;
                            iVar18 = iVar28;
                            if (local_508 <= iVar37) goto LAB_00044254;
                            goto LAB_00044606;
                          }
                        }
                        uVar22 = uVar22 + 4;
                        pbVar11 = pbVar2;
                      }
                      pbVar41 = pbVar41 + local_44c * 4;
                      iVar10 = iVar10 + local_46c * 4;
                    }
LAB_00044490:
                    *piVar4 = local_508;
                    *piVar5 = iVar29;
LAB_0004449a:
                    *piVar6 = local_4b8 + -1;
                  }
                  if (local_450 != (void *)0x0) {
                    free(local_450);
                  }
                  FUN_0003bd5a(&local_45c);
                  FUN_00035280(param_1[0x37],iVar20);
                  break;
                }
              }
            }
LAB_00044606:
            FUN_00035280(param_1[0x37],iVar20);
          }
          pcVar8 = strtok((char *)0x0,local_470);
          if (local_450 != (void *)0x0) {
            free(local_450);
          }
        }
        FUN_0003bd5a(&local_45c);
        local_4b8 = local_4b8 + 1;
      }
    }
  }
  if (local_2c == *piVar19) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
LAB_00043d26:
  iVar33 = local_4c4 + iVar29;
  if (uVar38 == local_448) goto LAB_00043d32;
  iVar33 = 0;
  pbVar11 = pbVar41;
  for (uVar22 = 0; uVar22 != local_44c; uVar22 = uVar22 + 1) {
    pbVar2 = pbVar11 + 4;
    if (*(int *)pbVar2 != 0) {
      iVar35 = (uint)*(byte *)(iVar23 + iVar33) - (uint)*pbVar2;
      if (iVar35 < 0) {
        iVar35 = -iVar35;
      }
      iVar40 = (uint)*(byte *)(iVar23 + iVar33 + 1) - (uint)pbVar11[5];
      if (iVar40 < 0) {
        iVar40 = -iVar40;
      }
      iVar31 = (uint)*(byte *)(iVar23 + iVar33 + 2) - (uint)pbVar11[6];
      if (iVar31 < 0) {
        iVar31 = -iVar31;
      }
      if ((((int)uVar15 < iVar40 || (int)uVar14 < iVar35) || ((int)uVar21 < iVar31)) &&
         (local_4fc < iVar40 + iVar35 + iVar31)) goto LAB_00043d3c;
    }
    iVar33 = iVar33 + 4;
    pbVar11 = pbVar2;
  }
  uVar38 = uVar38 + 1;
  pbVar41 = pbVar41 + iVar10;
  iVar23 = iVar23 + iVar18;
  goto LAB_00043d26;
}



/* ============================================================ */
/* Target 0x43c18 */
/* Ghidra name: FUN_00043438 */
/* Entry: 00043438 */

void FUN_00043438(undefined4 *param_1,int param_2,int param_3,int param_4,int param_5,char *param_6,
                 uint param_7,int param_8,float param_9,int *param_10,int *param_11,int *param_12)

{
  uint uVar1;
  byte *pbVar2;
  double dVar3;
  int *piVar4;
  int *piVar5;
  int *piVar6;
  size_t sVar7;
  char *pcVar8;
  undefined4 uVar9;
  int iVar10;
  byte *pbVar11;
  int iVar12;
  uint uVar13;
  uint uVar14;
  uint uVar15;
  uint uVar16;
  uint uVar17;
  int iVar18;
  int *piVar19;
  int iVar20;
  uint uVar21;
  uint uVar22;
  int iVar23;
  undefined4 uVar24;
  undefined4 *puVar25;
  int iVar26;
  int *piVar27;
  int iVar28;
  int iVar29;
  int iVar30;
  int iVar31;
  int iVar32;
  int iVar33;
  int iVar34;
  int iVar35;
  uint uVar36;
  int iVar37;
  uint uVar38;
  uint uVar39;
  int iVar40;
  byte *pbVar41;
  int local_518;
  int local_514;
  int local_508;
  int local_504;
  int local_500;
  int local_4fc;
  int local_4c4;
  int local_4b8;
  int local_4ac;
  int local_4a8;
  int local_4a4;
  int local_47c;
  int local_478;
  int local_474;
  char local_470 [4];
  uint local_46c;
  undefined4 local_468;
  int local_464;
  int *local_460;
  int local_45c;
  int local_458;
  undefined4 local_454;
  void *local_450;
  uint local_44c;
  uint local_448;
  undefined4 local_444;
  uint local_440;
  uint local_43c;
  int local_434;
  char acStack_42c [1024];
  int local_2c;
  
  piVar6 = param_12;
  piVar5 = param_11;
  piVar4 = param_10;
  uVar21 = param_7;
  pcVar8 = param_6;
  dVar3 = DAT_000436e8;
  piVar19 = *(int **)(DAT_000436f8 + 0x43456);
  local_2c = *piVar19;
  *param_10 = -1;
  *param_11 = -1;
  *param_12 = -1;
  uVar24 = *param_1;
  if ((int)((uint)((double)param_9 < dVar3) << 0x1f) < 0) {
    local_4fc = (int)(longlong)((1.0 - (double)param_9) * DAT_000436f0);
  }
  else {
    local_4fc = 0;
  }
  local_47c = param_4;
  local_478 = param_3;
  local_474 = param_2;
  FUN_000429f8(param_1,&local_46c,&local_468,&local_464);
  puVar25 = param_1 + 1;
  FUN_0003b8ac(param_1,&local_474,&local_478,&local_47c,&param_5,local_46c,local_468);
  if (param_1[4] == 0) {
    puVar25 = param_1 + 6;
    FUN_0004233c(param_1,puVar25,local_474,local_478,(local_47c - local_474) + 1,
                 (param_5 - local_478) + 1);
  }
  if (puVar25[3] != 0) {
    FUN_0003b3ac(puVar25);
    local_464 = puVar25[2];
    iVar26 = puVar25[3];
    iVar20 = DAT_000436fc + 0x4352a + local_464 * 0x20;
    uVar14 = (*(uint *)(iVar20 + 100) & uVar21) >> (*(uint *)(iVar20 + 0x70) & 0xff);
    uVar15 = (*(uint *)(iVar20 + 0x68) & uVar21) >> (*(uint *)(iVar20 + 0x74) & 0xff);
    uVar21 = (uVar21 & *(uint *)(iVar20 + 0x6c)) >> (*(uint *)(iVar20 + 0x78) & 0xff);
    if (param_1[0x37] != 0) {
      memset(acStack_42c,0,0x400);
      sVar7 = strlen(pcVar8);
      memcpy(acStack_42c,pcVar8,sVar7 + 1);
      local_470[0] = '|';
      local_470[1] = '\0';
      pcVar8 = strtok(acStack_42c,local_470);
      local_4b8 = 1;
      while (pcVar8 != (char *)0x0) {
        local_45c = 0;
        local_458 = 0;
        local_454 = 0;
        iVar20 = FUN_0005141c(uVar24,pcVar8,&local_45c);
        if (iVar20 == 0) {
          uVar9 = FUN_0003ac9a(param_1[0x37],pcVar8);
          iVar20 = FUN_0003a672(param_1[0x37],param_1[0x38],param_1[0x39],uVar9);
        }
        else {
          iVar20 = local_458 - local_45c;
          uVar9 = (**(code **)(*(int *)param_1[0x37] + 0x2c0))((int *)param_1[0x37],iVar20);
          (**(code **)(*(int *)param_1[0x37] + 0x340))
                    ((int *)param_1[0x37],uVar9,0,iVar20,local_45c);
          iVar20 = FUN_0003a672(param_1[0x37],param_1[0x38],param_1[0x3a],uVar9,0,iVar20);
        }
        FUN_00035280(param_1[0x37],uVar9);
        if (iVar20 == 0) {
LAB_00043644:
          pcVar8 = strtok((char *)0x0,local_470);
        }
        else {
          AndroidBitmap_getInfo(param_1[0x37],iVar20,&local_440);
          if (local_434 != 1) {
            FUN_00035280(param_1[0x37],iVar20);
            goto LAB_00043644;
          }
          local_460 = (int *)0x0;
          AndroidBitmap_lockPixels(param_1[0x37],iVar20,&local_460);
          uVar38 = local_43c;
          uVar16 = local_440;
          piVar27 = local_460;
          if (local_460 == (int *)0x0) {
            FUN_00035280(param_1[0x37],iVar20);
            goto LAB_00043644;
          }
          uVar22 = 1 - local_440;
          if (1 < local_440) {
            uVar22 = 0;
          }
          if (local_43c == 0) {
            uVar22 = uVar22 | 1;
          }
          if (uVar22 == 0) {
            local_450 = malloc(local_43c * local_440 * 4);
            local_44c = uVar16;
            local_448 = uVar38;
          }
          if (local_450 != (void *)0x0) {
            local_444 = 0xffffffff;
            for (uVar16 = 0; uVar16 < local_44c * local_448; uVar16 = uVar16 + 1) {
              if (*piVar27 == 0) {
                local_444 = 0;
              }
              *(int *)((int)local_450 + uVar16 * 4) = *piVar27;
              piVar27 = piVar27 + 1;
            }
          }
          AndroidBitmap_unlockPixels(param_1[0x37],iVar20);
          if (local_450 == (void *)0x0) {
            FUN_00035280(param_1[0x37],iVar20);
          }
          else {
            FUN_0003b310(&local_450);
            if ((1 < local_44c) || (1 < local_448)) {
              iVar29 = local_47c - local_44c;
              iVar37 = iVar29 + 1;
              local_508 = local_474;
              if (local_474 <= iVar37) {
                iVar12 = (param_5 - local_448) + 1;
                local_514 = local_478;
                if (local_478 <= iVar12) {
                  if (param_8 == 0) {
                    iVar28 = iVar26 + (local_46c * local_478 + local_474) * 4;
                    iVar29 = local_474;
                    iVar18 = iVar28;
LAB_0004384c:
                    pbVar41 = (byte *)((int)local_450 + -4);
                    iVar10 = iVar28;
                    for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                      uVar22 = 0;
                      pbVar11 = pbVar41;
                      for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                        pbVar2 = pbVar11 + 4;
                        if (*(int *)pbVar2 != 0) {
                          iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                          if (iVar34 < 0) {
                            iVar34 = -iVar34;
                          }
                          iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                          if (iVar32 < 0) {
                            iVar32 = -iVar32;
                          }
                          iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                          if (iVar30 < 0) {
                            iVar30 = -iVar30;
                          }
                          if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                              ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                            iVar29 = iVar29 + 1;
                            iVar28 = iVar28 + 4;
                            if (iVar29 <= iVar37) goto LAB_0004384c;
                            local_514 = local_514 + 1;
                            iVar28 = iVar18 + local_46c * 4;
                            iVar29 = local_474;
                            iVar18 = iVar28;
                            if (local_514 <= iVar12) goto LAB_0004384c;
                            goto LAB_00044606;
                          }
                        }
                        uVar22 = uVar22 + 4;
                        pbVar11 = pbVar2;
                      }
                      pbVar41 = pbVar41 + local_44c * 4;
                      iVar10 = iVar10 + local_46c * 4;
                    }
LAB_00044110:
                    *piVar4 = iVar29;
                    *piVar5 = local_514;
LAB_00043eb2:
                    *piVar6 = local_4b8 + -1;
                  }
                  else {
                    if (param_8 == 1) {
                      uVar38 = iVar37 - local_474;
                      uVar22 = iVar12 - local_478;
                      uVar16 = uVar22;
                      if ((int)uVar22 < (int)uVar38) {
                        uVar16 = uVar38;
                      }
                      uVar17 = DAT_00043b50 & uVar16;
                      if ((int)uVar17 < 0) {
                        uVar17 = (uVar17 - 1 | 0xfffffffe) + 1;
                      }
                      iVar28 = local_478 + (int)(uVar22 + 1) / 2;
                      iVar29 = local_474 + (int)(uVar38 + 1) / 2;
                      local_500 = iVar26 + (local_46c * iVar28 + iVar29) * 4;
                      iVar10 = local_44c * 4;
                      iVar18 = local_46c * 4;
                      local_4a4 = (iVar28 * local_46c * 0x3fffffff + local_46c * iVar28) * 4;
                      local_518 = iVar28;
                      local_504 = iVar29;
                      local_4ac = local_500;
                      local_4a8 = local_500;
                      for (local_4c4 = 0; local_4c4 <= (int)((int)uVar16 / 2 + uVar17);
                          local_4c4 = local_4c4 + 1) {
                        iVar32 = local_4a8;
                        for (iVar34 = local_504; iVar34 <= local_4c4 + iVar29; iVar34 = iVar34 + 1)
                        {
                          if (iVar34 <= iVar37 && local_474 <= iVar34) {
                            if (iVar28 <= iVar12 && local_478 <= iVar28) {
                              pbVar41 = (byte *)((int)local_450 + -4);
                              iVar30 = iVar32 + local_4a4;
                              for (uVar38 = 0; uVar38 != local_448; uVar38 = uVar38 + 1) {
                                uVar13 = 0;
                                pbVar11 = pbVar41;
                                for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                  pbVar2 = pbVar11 + 4;
                                  if (*(int *)pbVar2 != 0) {
                                    iVar23 = (uint)*(byte *)(iVar30 + uVar13) - (uint)*pbVar2;
                                    if (iVar23 < 0) {
                                      iVar23 = -iVar23;
                                    }
                                    iVar33 = (uint)*(byte *)(iVar30 + uVar13 + 1) - (uint)pbVar11[5]
                                    ;
                                    if (iVar33 < 0) {
                                      iVar33 = -iVar33;
                                    }
                                    iVar35 = (uint)*(byte *)(iVar30 + uVar13 + 2) - (uint)pbVar11[6]
                                    ;
                                    if (iVar35 < 0) {
                                      iVar35 = -iVar35;
                                    }
                                    if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar23) ||
                                        ((int)uVar21 < iVar35)) &&
                                       (local_4fc < iVar33 + iVar23 + iVar35)) goto LAB_00043a40;
                                  }
                                  uVar13 = uVar13 + 4;
                                  pbVar11 = pbVar2;
                                }
                                iVar30 = iVar30 + iVar18;
                                pbVar41 = pbVar41 + iVar10;
                              }
                              *piVar4 = iVar34;
                              *piVar5 = iVar28;
                              goto LAB_0004449a;
                            }
LAB_00043a40:
                            if (local_518 <= iVar12 && local_478 <= local_518) {
                              pbVar41 = (byte *)((int)local_450 + -4);
                              iVar30 = iVar32;
                              for (uVar38 = 0; uVar38 != local_448; uVar38 = uVar38 + 1) {
                                uVar13 = 0;
                                pbVar11 = pbVar41;
                                for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                  pbVar2 = pbVar11 + 4;
                                  if (*(int *)pbVar2 != 0) {
                                    iVar23 = (uint)*(byte *)(iVar30 + uVar13) - (uint)*pbVar2;
                                    if (iVar23 < 0) {
                                      iVar23 = -iVar23;
                                    }
                                    iVar33 = (uint)*(byte *)(iVar30 + uVar13 + 1) - (uint)pbVar11[5]
                                    ;
                                    if (iVar33 < 0) {
                                      iVar33 = -iVar33;
                                    }
                                    iVar35 = (uint)*(byte *)(iVar30 + uVar13 + 2) - (uint)pbVar11[6]
                                    ;
                                    if (iVar35 < 0) {
                                      iVar35 = -iVar35;
                                    }
                                    if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar23) ||
                                        ((int)uVar21 < iVar35)) &&
                                       (local_4fc < iVar33 + iVar23 + iVar35)) goto LAB_00043b2c;
                                  }
                                  uVar13 = uVar13 + 4;
                                  pbVar11 = pbVar2;
                                }
                                iVar30 = iVar30 + iVar18;
                                pbVar41 = pbVar41 + iVar10;
                              }
                              *piVar4 = iVar34;
                              *piVar5 = local_518;
                              goto LAB_0004449a;
                            }
                          }
LAB_00043b2c:
                          iVar32 = iVar32 + 4;
                        }
                        iVar32 = local_500;
                        iVar30 = local_4ac;
                        for (iVar34 = iVar28; iVar34 <= local_518; iVar34 = iVar34 + 1) {
                          if ((local_504 <= iVar37 && local_474 <= local_504) &&
                             (iVar34 <= iVar12 && local_478 <= iVar34)) {
                            iVar23 = iVar30;
                            pbVar41 = (byte *)((int)local_450 + -4);
                            for (uVar38 = 0; iVar33 = local_504, uVar38 != local_448;
                                uVar38 = uVar38 + 1) {
                              uVar13 = 0;
                              pbVar11 = pbVar41;
                              for (uVar22 = uVar13; uVar22 != local_44c; uVar22 = uVar22 + 1) {
                                pbVar2 = pbVar11 + 4;
                                if (*(int *)pbVar2 != 0) {
                                  uVar39 = (uint)*(byte *)(iVar23 + uVar13) - (uint)*pbVar2;
                                  iVar33 = (uint)*(byte *)(iVar23 + uVar13 + 1) - (uint)pbVar11[5];
                                  if (iVar33 < 0) {
                                    iVar33 = -iVar33;
                                  }
                                  uVar36 = (uint)*(byte *)(iVar23 + uVar13 + 2) - (uint)pbVar11[6];
                                  uVar1 = (int)uVar39 >> 0x1f;
                                  iVar35 = (uVar39 ^ uVar1) - uVar1;
                                  uVar39 = (int)uVar36 >> 0x1f;
                                  iVar40 = (uVar36 ^ uVar39) - uVar39;
                                  if ((((int)uVar15 < iVar33 || (int)uVar14 < iVar35) ||
                                      ((int)uVar21 < iVar40)) &&
                                     (local_4fc < iVar33 + iVar35 + iVar40)) {
                                    uVar38 = 0;
                                    iVar23 = iVar32;
                                    pbVar41 = (byte *)((int)local_450 + -4);
                                    goto LAB_00043d26;
                                  }
                                }
                                uVar13 = uVar13 + 4;
                                pbVar11 = pbVar2;
                              }
                              pbVar41 = pbVar41 + iVar10;
                              iVar23 = iVar23 + iVar18;
                            }
LAB_00043d32:
                            *piVar4 = iVar33;
                            *piVar5 = iVar34;
                            goto LAB_0004449a;
                          }
LAB_00043d3c:
                          iVar32 = iVar32 + iVar18;
                          iVar30 = iVar30 + iVar18;
                        }
                        local_518 = local_518 + 1;
                        iVar28 = iVar28 + -1;
                        local_504 = local_504 + -1;
                        local_500 = local_500 + local_46c * -4 + 4;
                        local_4ac = local_4ac + ~local_46c * 4;
                        local_4a8 = local_4a8 + (local_46c - 1) * 4;
                        local_4a4 = local_4a4 + local_46c * -8;
                      }
                      goto LAB_00044606;
                    }
                    iVar18 = iVar37;
                    iVar28 = iVar12;
                    if (param_8 == 2) {
                      iVar12 = iVar26 + (local_46c * iVar12 + iVar37) * 4;
                      iVar29 = iVar12;
LAB_00043eca:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar12;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            uVar13 = (int)uVar17 >> 0x1f;
                            iVar32 = (uVar17 ^ uVar13) - uVar13;
                            uVar17 = (int)uVar39 >> 0x1f;
                            iVar30 = (uVar39 ^ uVar17) - uVar17;
                            if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30)) {
                              iVar18 = iVar18 + -1;
                              iVar12 = iVar12 + -4;
                              if (local_474 <= iVar18) goto LAB_00043eca;
                              iVar28 = iVar28 + -1;
                              iVar12 = iVar29 + local_46c * -4;
                              iVar18 = iVar37;
                              iVar29 = iVar12;
                              if (iVar28 < local_478) goto LAB_00044606;
                              goto LAB_00043eca;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
LAB_00043ea6:
                      *piVar4 = iVar18;
                      *piVar5 = iVar28;
                      goto LAB_00043eb2;
                    }
                    if (param_8 == 3) {
                      iVar12 = iVar26 + (local_46c * iVar12 + local_474) * 4;
                      iVar18 = local_474;
                      iVar29 = iVar12;
LAB_00044002:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar12;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            uVar13 = (int)uVar17 >> 0x1f;
                            iVar32 = (uVar17 ^ uVar13) - uVar13;
                            uVar17 = (int)uVar39 >> 0x1f;
                            iVar30 = (uVar39 ^ uVar17) - uVar17;
                            if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30)) {
                              iVar18 = iVar18 + 1;
                              iVar12 = iVar12 + 4;
                              if (iVar18 <= iVar37) goto LAB_00044002;
                              iVar28 = iVar28 + -1;
                              iVar12 = iVar29 + local_46c * -4;
                              iVar18 = local_474;
                              iVar29 = iVar12;
                              if (local_478 <= iVar28) goto LAB_00044002;
                              goto LAB_00044606;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
                      goto LAB_00043ea6;
                    }
                    if (param_8 == 4) {
                      iVar28 = iVar26 + (local_46c * local_478 + iVar29 + 1) * 4;
                      iVar29 = iVar37;
                      iVar18 = iVar28;
LAB_0004412c:
                      pbVar41 = (byte *)((int)local_450 + -4);
                      iVar10 = iVar28;
                      for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                        uVar22 = 0;
                        pbVar11 = pbVar41;
                        for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                          pbVar2 = pbVar11 + 4;
                          if (*(int *)pbVar2 != 0) {
                            iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                            if (iVar34 < 0) {
                              iVar34 = -iVar34;
                            }
                            iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                            if (iVar32 < 0) {
                              iVar32 = -iVar32;
                            }
                            iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                            if (iVar30 < 0) {
                              iVar30 = -iVar30;
                            }
                            if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                                ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                              iVar29 = iVar29 + -1;
                              iVar28 = iVar28 + -4;
                              if (local_474 <= iVar29) goto LAB_0004412c;
                              local_514 = local_514 + 1;
                              iVar28 = iVar18 + local_46c * 4;
                              iVar29 = iVar37;
                              iVar18 = iVar28;
                              if (iVar12 < local_514) goto LAB_00044606;
                              goto LAB_0004412c;
                            }
                          }
                          uVar22 = uVar22 + 4;
                          pbVar11 = pbVar2;
                        }
                        pbVar41 = pbVar41 + local_44c * 4;
                        iVar10 = iVar10 + local_46c * 4;
                      }
                      goto LAB_00044110;
                    }
                    if (param_8 != 5) {
                      if (param_8 == 6) {
                        iVar37 = iVar26 + (local_46c * local_478 + iVar29 + 1) * 4;
                        iVar28 = local_478;
                        iVar29 = iVar37;
LAB_00044380:
                        pbVar41 = (byte *)((int)local_450 + -4);
                        iVar10 = iVar37;
                        for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                          uVar22 = 0;
                          pbVar11 = pbVar41;
                          for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                            pbVar2 = pbVar11 + 4;
                            if (*(int *)pbVar2 != 0) {
                              uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                              iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                              if (iVar34 < 0) {
                                iVar34 = -iVar34;
                              }
                              uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                              uVar13 = (int)uVar17 >> 0x1f;
                              iVar32 = (uVar17 ^ uVar13) - uVar13;
                              uVar17 = (int)uVar39 >> 0x1f;
                              iVar30 = (uVar39 ^ uVar17) - uVar17;
                              if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                  ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30))
                              {
                                iVar28 = iVar28 + 1;
                                iVar37 = iVar37 + local_46c * 4;
                                if (iVar28 <= iVar12) goto LAB_00044380;
                                iVar18 = iVar18 + -1;
                                iVar37 = iVar29 + -4;
                                iVar28 = local_478;
                                iVar29 = iVar37;
                                if (local_474 <= iVar18) goto LAB_00044380;
                                goto LAB_00044606;
                              }
                            }
                            uVar22 = uVar22 + 4;
                            pbVar11 = pbVar2;
                          }
                          pbVar41 = pbVar41 + local_44c * 4;
                          iVar10 = iVar10 + local_46c * 4;
                        }
                      }
                      else {
                        if (param_8 == 7) {
                          iVar28 = iVar26 + (local_46c * iVar12 + local_474) * 4;
                          iVar29 = iVar12;
                          iVar18 = iVar28;
LAB_000444b2:
                          pbVar41 = (byte *)((int)local_450 + -4);
                          iVar10 = iVar28;
                          for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                            uVar22 = 0;
                            pbVar11 = pbVar41;
                            for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                              pbVar2 = pbVar11 + 4;
                              if (*(int *)pbVar2 != 0) {
                                iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                                if (iVar34 < 0) {
                                  iVar34 = -iVar34;
                                }
                                iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                                if (iVar32 < 0) {
                                  iVar32 = -iVar32;
                                }
                                iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                                if (iVar30 < 0) {
                                  iVar30 = -iVar30;
                                }
                                if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                                    ((int)uVar21 < iVar30)) &&
                                   (local_4fc < iVar32 + iVar34 + iVar30)) {
                                  iVar29 = iVar29 + -1;
                                  iVar28 = iVar28 + local_46c * -4;
                                  if (local_478 <= iVar29) goto LAB_000444b2;
                                  iVar28 = iVar18 + 4;
                                  local_508 = local_508 + 1;
                                  iVar29 = iVar12;
                                  iVar18 = iVar28;
                                  if (iVar37 < local_508) goto LAB_00044606;
                                  goto LAB_000444b2;
                                }
                              }
                              uVar22 = uVar22 + 4;
                              pbVar11 = pbVar2;
                            }
                            pbVar41 = pbVar41 + local_44c * 4;
                            iVar10 = iVar10 + local_46c * 4;
                          }
                          goto LAB_00044490;
                        }
                        if (param_8 != 8) goto LAB_00044606;
                        iVar37 = iVar26 + (local_46c * iVar12 + iVar37) * 4;
                        iVar29 = iVar37;
LAB_000445e8:
                        pbVar41 = (byte *)((int)local_450 + -4);
                        iVar10 = iVar37;
                        for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                          uVar22 = 0;
                          pbVar11 = pbVar41;
                          for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                            pbVar2 = pbVar11 + 4;
                            if (*(int *)pbVar2 != 0) {
                              uVar17 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                              iVar34 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                              if (iVar34 < 0) {
                                iVar34 = -iVar34;
                              }
                              uVar39 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                              uVar13 = (int)uVar17 >> 0x1f;
                              iVar32 = (uVar17 ^ uVar13) - uVar13;
                              uVar17 = (int)uVar39 >> 0x1f;
                              iVar30 = (uVar39 ^ uVar17) - uVar17;
                              if ((((int)uVar15 < iVar34 || (int)uVar14 < iVar32) ||
                                  ((int)uVar21 < iVar30)) && (local_4fc < iVar34 + iVar32 + iVar30))
                              {
                                iVar28 = iVar28 + -1;
                                iVar37 = iVar37 + local_46c * -4;
                                if (local_478 <= iVar28) goto LAB_000445e8;
                                iVar18 = iVar18 + -1;
                                iVar37 = iVar29 + -4;
                                iVar28 = iVar12;
                                iVar29 = iVar37;
                                if (iVar18 < local_474) goto LAB_00044606;
                                goto LAB_000445e8;
                              }
                            }
                            uVar22 = uVar22 + 4;
                            pbVar11 = pbVar2;
                          }
                          pbVar41 = pbVar41 + local_44c * 4;
                          iVar10 = iVar10 + local_46c * 4;
                        }
                      }
                      goto LAB_00043ea6;
                    }
                    iVar28 = iVar26 + (local_46c * local_478 + local_474) * 4;
                    iVar29 = local_478;
                    iVar18 = iVar28;
LAB_00044254:
                    pbVar41 = (byte *)((int)local_450 + -4);
                    iVar10 = iVar28;
                    for (uVar16 = 0; uVar16 != local_448; uVar16 = uVar16 + 1) {
                      uVar22 = 0;
                      pbVar11 = pbVar41;
                      for (uVar38 = uVar22; uVar38 != local_44c; uVar38 = uVar38 + 1) {
                        pbVar2 = pbVar11 + 4;
                        if (*(int *)pbVar2 != 0) {
                          iVar34 = (uint)*(byte *)(iVar10 + uVar22) - (uint)*pbVar2;
                          if (iVar34 < 0) {
                            iVar34 = -iVar34;
                          }
                          iVar32 = (uint)*(byte *)(iVar10 + uVar22 + 1) - (uint)pbVar11[5];
                          if (iVar32 < 0) {
                            iVar32 = -iVar32;
                          }
                          iVar30 = (uint)*(byte *)(iVar10 + uVar22 + 2) - (uint)pbVar11[6];
                          if (iVar30 < 0) {
                            iVar30 = -iVar30;
                          }
                          if ((((int)uVar15 < iVar32 || (int)uVar14 < iVar34) ||
                              ((int)uVar21 < iVar30)) && (local_4fc < iVar32 + iVar34 + iVar30)) {
                            iVar29 = iVar29 + 1;
                            iVar28 = iVar28 + local_46c * 4;
                            if (iVar29 <= iVar12) goto LAB_00044254;
                            iVar28 = iVar18 + 4;
                            local_508 = local_508 + 1;
                            iVar29 = local_478;
                            iVar18 = iVar28;
                            if (local_508 <= iVar37) goto LAB_00044254;
                            goto LAB_00044606;
                          }
                        }
                        uVar22 = uVar22 + 4;
                        pbVar11 = pbVar2;
                      }
                      pbVar41 = pbVar41 + local_44c * 4;
                      iVar10 = iVar10 + local_46c * 4;
                    }
LAB_00044490:
                    *piVar4 = local_508;
                    *piVar5 = iVar29;
LAB_0004449a:
                    *piVar6 = local_4b8 + -1;
                  }
                  if (local_450 != (void *)0x0) {
                    free(local_450);
                  }
                  FUN_0003bd5a(&local_45c);
                  FUN_00035280(param_1[0x37],iVar20);
                  break;
                }
              }
            }
LAB_00044606:
            FUN_00035280(param_1[0x37],iVar20);
          }
          pcVar8 = strtok((char *)0x0,local_470);
          if (local_450 != (void *)0x0) {
            free(local_450);
          }
        }
        FUN_0003bd5a(&local_45c);
        local_4b8 = local_4b8 + 1;
      }
    }
  }
  if (local_2c == *piVar19) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
LAB_00043d26:
  iVar33 = local_4c4 + iVar29;
  if (uVar38 == local_448) goto LAB_00043d32;
  iVar33 = 0;
  pbVar11 = pbVar41;
  for (uVar22 = 0; uVar22 != local_44c; uVar22 = uVar22 + 1) {
    pbVar2 = pbVar11 + 4;
    if (*(int *)pbVar2 != 0) {
      iVar35 = (uint)*(byte *)(iVar23 + iVar33) - (uint)*pbVar2;
      if (iVar35 < 0) {
        iVar35 = -iVar35;
      }
      iVar40 = (uint)*(byte *)(iVar23 + iVar33 + 1) - (uint)pbVar11[5];
      if (iVar40 < 0) {
        iVar40 = -iVar40;
      }
      iVar31 = (uint)*(byte *)(iVar23 + iVar33 + 2) - (uint)pbVar11[6];
      if (iVar31 < 0) {
        iVar31 = -iVar31;
      }
      if ((((int)uVar15 < iVar40 || (int)uVar14 < iVar35) || ((int)uVar21 < iVar31)) &&
         (local_4fc < iVar40 + iVar35 + iVar31)) goto LAB_00043d3c;
    }
    iVar33 = iVar33 + 4;
    pbVar11 = pbVar2;
  }
  uVar38 = uVar38 + 1;
  pbVar41 = pbVar41 + iVar10;
  iVar23 = iVar23 + iVar18;
  goto LAB_00043d26;
}



/* ============================================================ */
/* Target 0x42a32 */
/* Ghidra name: FUN_000429f8 */
/* Entry: 000429f8 */

void FUN_000429f8(int param_1,uint *param_2,uint *param_3,undefined4 *param_4)

{
  int iVar1;
  int iVar2;
  uint uVar3;
  uint uVar4;
  
  if (((*(int *)((int)&DAT_00042a78 + DAT_00042a70) == 0) ||
      (*(int *)((int)&DAT_00042a7c + DAT_00042a70) == 0)) ||
     (*(int *)((int)&DAT_00042a80 + DAT_00042a70) == 0)) {
    FUN_0004233c(param_1,param_1 + 0x18,0,0,0,0,param_3);
    iVar1 = DAT_00042a74;
    iVar2 = *(int *)(param_1 + 0x20);
    *(undefined4 *)(DAT_00042a74 + 0x42a9c) = *(undefined4 *)(param_1 + 0x18);
    *(undefined4 *)(iVar1 + 0x42aa0) = *(undefined4 *)(param_1 + 0x1c);
    *(int *)(iVar1 + 0x42aa4) = *(int *)(DAT_00042a78 + iVar2 * 0x20 + 0x42a98) << 3;
  }
  if (*(int *)(DAT_00042a7c + 0x42ac2) == 0) {
    uVar3 = *(uint *)(DAT_00042a7c + 0x42aba);
    *param_2 = *(uint *)(DAT_00042a7c + 0x42ab6);
    *param_3 = uVar3;
  }
  else {
    uVar3 = *(uint *)(DAT_00042a7c + 0x42ab6);
    uVar4 = *(uint *)(DAT_00042a7c + 0x42aba);
    if (uVar3 < uVar4) {
      *param_2 = uVar3;
    }
    else {
      *param_2 = uVar4;
    }
    if (uVar4 < uVar3) {
      *param_3 = uVar3;
    }
    else {
      *param_3 = uVar4;
    }
  }
  *param_4 = *(undefined4 *)(DAT_00042a80 + 0x42ae4);
  return;
}



/* ============================================================ */
/* Target 0x4b448 */
/* Ghidra name: FUN_0004a5e8 */
/* Entry: 0004a5e8 */

void FUN_0004a5e8(int param_1,int param_2,int param_3,int param_4,int param_5,undefined4 param_6,
                 undefined4 param_7,int param_8,float param_9,int *param_10,int *param_11)

{
  uint uVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  uint uVar6;
  uint uVar7;
  int iVar8;
  int iVar9;
  uint uVar10;
  uint uVar11;
  int *piVar12;
  int iVar13;
  int iVar14;
  int iVar15;
  int iVar16;
  uint uVar17;
  uint uVar18;
  int iVar19;
  int iVar20;
  int iVar21;
  int iVar22;
  uint uVar23;
  uint *puVar24;
  int iVar25;
  uint uVar26;
  int iVar27;
  int iVar28;
  int iVar29;
  uint uVar30;
  int iVar31;
  uint uVar32;
  int iVar33;
  int iVar34;
  uint uVar35;
  uint local_f0;
  uint *local_ec;
  int local_e8;
  int local_e4;
  int local_dc;
  int local_d8;
  int local_9c;
  int local_78;
  int local_70;
  int local_6c;
  int local_4c;
  int local_48;
  int local_44;
  int local_40 [7];
  
  iVar29 = param_8;
  *param_10 = -1;
  piVar12 = (int *)(param_1 + 4);
  *param_11 = -1;
  local_4c = param_4;
  local_48 = param_3;
  local_44 = param_2;
  if (*(int *)(param_1 + 0x10) == 0) {
    piVar12 = (int *)(param_1 + 0x18);
    FUN_0004233c(param_1,piVar12,0,0,0,0);
  }
  iVar14 = piVar12[3];
  if (iVar14 == 0) {
    return;
  }
  iVar15 = piVar12[1];
  iVar25 = piVar12[2];
  iVar16 = *piVar12;
  iVar13 = *(int *)(DAT_0004a940 + iVar25 * 0x20 + 0x4a698);
  FUN_0003b8ac(param_1,&local_44,&local_48,&local_4c,&param_5,iVar16,iVar15);
  iVar9 = (uint)((double)param_9 < DAT_0004a930) << 0x1f;
  if (-1 < iVar9) {
    local_d8 = 0;
  }
  if (iVar9 < 0) {
    local_d8 = (int)(longlong)((1.0 - (double)param_9) * DAT_0004a938);
  }
  local_40[0] = 0;
  local_40[1] = 0;
  iVar9 = DAT_0004a944 + 0x4a694 + iVar25 * 0x20;
  local_40[2] = 0;
  uVar1 = *(uint *)(iVar9 + 100);
  uVar4 = *(uint *)(iVar9 + 0x70);
  uVar7 = *(uint *)(iVar9 + 0x68);
  uVar2 = *(uint *)(iVar9 + 0x74);
  uVar5 = *(uint *)(iVar9 + 0x6c);
  uVar10 = *(uint *)(iVar9 + 0x78);
  iVar9 = FUN_000457fc(param_1,param_6,local_40,iVar25);
  local_40[3] = 0;
  local_40[4] = 0;
  local_40[5] = 0;
  iVar25 = FUN_0004858c(param_1,param_7,local_40 + 3,iVar25);
  if (iVar29 == 0) {
    local_ec = (uint *)(iVar13 * (iVar16 * local_48 + local_44) + iVar14);
    for (uVar11 = local_48; (int)uVar11 <= param_5; uVar11 = uVar11 + 1) {
      puVar24 = local_ec;
      for (iVar8 = local_44; iVar8 <= local_4c; iVar8 = iVar8 + 1) {
        uVar6 = *puVar24;
        local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
        uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
        uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
        for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
          iVar21 = local_40[0] + iVar29 * 0x18;
          iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
          if (iVar31 < 0) {
            iVar31 = -iVar31;
          }
          if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004a7a6:
            iVar22 = *(int *)(iVar21 + 4) - uVar3;
            iVar21 = *(int *)(iVar21 + 8) - uVar6;
            if (iVar22 < 0) {
              iVar22 = -iVar22;
            }
            if (iVar21 < 0) {
              iVar21 = -iVar21;
            }
            if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004a908;
          }
          else {
            iVar22 = *(int *)(iVar21 + 4) - uVar3;
            if (iVar22 < 0) {
              iVar22 = -iVar22;
            }
            if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004a7a6;
            iVar22 = *(int *)(iVar21 + 8) - uVar6;
            if (iVar22 < 0) {
              iVar22 = -iVar22;
            }
            if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004a7a6;
LAB_0004a908:
            iVar31 = 0;
            while( true ) {
              if (iVar25 <= iVar31) goto LAB_0004c452;
              iVar21 = local_40[3] + iVar31 * 0x18;
              uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
              if (iVar15 - 1U < uVar26) break;
              uVar32 = iVar8 + *(int *)(iVar21 + 0x10);
              uVar23 = uVar26 >> 0x1f;
              if (iVar16 - 1U < uVar32) {
                uVar23 = 1;
              }
              if ((uVar23 != 0) || ((int)uVar32 < 0)) break;
              uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar32));
              local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
              uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
              uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
              iVar22 = 0;
              for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1)
              {
                iVar33 = *(int *)(iVar21 + 4) + iVar22;
                iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004a8ca:
                  iVar34 = *(int *)(iVar33 + 4) - uVar3;
                  if (iVar34 < 0) {
                    iVar34 = -iVar34;
                  }
                  iVar33 = *(int *)(iVar33 + 8) - uVar6;
                  if (iVar33 < 0) {
                    iVar33 = -iVar33;
                  }
                  if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004a918;
                }
                else {
                  iVar34 = *(int *)(iVar33 + 4) - uVar3;
                  if (iVar34 < 0) {
                    iVar34 = -iVar34;
                  }
                  if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004a8ca;
                  iVar34 = *(int *)(iVar33 + 8) - uVar6;
                  if (iVar34 < 0) {
                    iVar34 = -iVar34;
                  }
                  if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004a8ca;
                }
                iVar22 = iVar22 + 0x18;
              }
              iVar31 = iVar31 + 1;
            }
          }
LAB_0004a918:
        }
        puVar24 = (uint *)((int)puVar24 + iVar13);
      }
      local_ec = (uint *)((int)local_ec + iVar16 * iVar13);
    }
  }
  else if (iVar29 == 1) {
    uVar6 = local_4c - local_44;
    uVar11 = param_5 - local_48;
    uVar3 = uVar11;
    if ((int)uVar11 < (int)uVar6) {
      uVar3 = uVar6;
    }
    uVar26 = DAT_0004aca4 & uVar3;
    if ((int)uVar26 < 0) {
      uVar26 = (uVar26 - 1 | 0xfffffffe) + 1;
    }
    iVar29 = local_44 + (int)(uVar6 + 1) / 2;
    local_f0 = local_48 + (int)(uVar11 + 1) / 2;
    uVar6 = iVar16 - 1;
    local_e8 = 0;
    iVar31 = iVar13 * (iVar16 * local_f0 + iVar29) + iVar14;
    local_6c = 0;
    local_70 = 0;
    local_78 = 0;
    local_e4 = iVar29;
    local_dc = local_f0;
    for (local_9c = 0; local_9c <= (int)((int)uVar3 / 2 + uVar26); local_9c = local_9c + 1) {
      puVar24 = (uint *)(iVar31 + local_6c);
      for (iVar8 = local_e4; iVar21 = local_9c + iVar29, uVar11 = local_dc, iVar8 <= iVar21;
          iVar8 = iVar8 + 1) {
        if ((local_44 <= iVar8) && (iVar8 <= local_4c)) {
          if ((local_48 <= local_dc) && (local_dc <= param_5)) {
            uVar32 = *(uint *)((int)puVar24 + local_e8);
            uVar35 = (uVar32 & uVar1) >> (uVar4 & 0xff);
            uVar23 = (uVar32 & uVar7) >> (uVar2 & 0xff);
            uVar32 = (uVar32 & uVar5) >> (uVar10 & 0xff);
            for (iVar21 = 0; iVar21 < iVar9; iVar21 = iVar21 + 1) {
              iVar27 = local_40[0] + iVar21 * 0x18;
              iVar22 = *(int *)(local_40[0] + iVar21 * 0x18) - uVar35;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar27 + 0xc) < iVar22) {
LAB_0004aafa:
                iVar28 = *(int *)(iVar27 + 4) - uVar23;
                iVar27 = *(int *)(iVar27 + 8) - uVar32;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (iVar27 < 0) {
                  iVar27 = -iVar27;
                }
                if (iVar22 + iVar28 + iVar27 <= local_d8) goto LAB_0004ac40;
              }
              else {
                iVar28 = *(int *)(iVar27 + 4) - uVar23;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (*(int *)(iVar27 + 0x10) < iVar28) goto LAB_0004aafa;
                iVar28 = *(int *)(iVar27 + 8) - uVar32;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (*(int *)(iVar27 + 0x14) < iVar28) goto LAB_0004aafa;
LAB_0004ac40:
                iVar22 = 0;
                while( true ) {
                  if (iVar25 <= iVar22) goto LAB_0004c452;
                  iVar27 = local_40[3] + iVar22 * 0x18;
                  uVar18 = local_dc + *(int *)(iVar27 + 0x14);
                  if (iVar15 - 1U < uVar18) break;
                  uVar17 = iVar8 + *(int *)(iVar27 + 0x10);
                  uVar30 = uVar18 >> 0x1f;
                  if (uVar6 < uVar17) {
                    uVar30 = 1;
                  }
                  if ((uVar30 != 0) || ((int)uVar17 < 0)) break;
                  uVar32 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar18 + uVar17));
                  uVar35 = (uVar32 & uVar1) >> (uVar4 & 0xff);
                  uVar23 = (uVar32 & uVar7) >> (uVar2 & 0xff);
                  uVar32 = (uVar32 & uVar5) >> (uVar10 & 0xff);
                  iVar28 = 0;
                  for (iVar33 = 0; iVar33 < *(int *)(local_40[3] + iVar22 * 0x18);
                      iVar33 = iVar33 + 1) {
                    iVar19 = *(int *)(iVar27 + 4) + iVar28;
                    iVar34 = *(int *)(*(int *)(iVar27 + 4) + iVar28) - uVar35;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar19 + 0xc) < iVar34) {
LAB_0004ac06:
                      iVar20 = *(int *)(iVar19 + 4) - uVar23;
                      iVar19 = *(int *)(iVar19 + 8) - uVar32;
                      if (iVar20 < 0) {
                        iVar20 = -iVar20;
                      }
                      if (iVar19 < 0) {
                        iVar19 = -iVar19;
                      }
                      if (local_d8 < iVar34 + iVar20 + iVar19) goto LAB_0004ac52;
                    }
                    else {
                      iVar20 = *(int *)(iVar19 + 4) - uVar23;
                      if (iVar20 < 0) {
                        iVar20 = -iVar20;
                      }
                      if (*(int *)(iVar19 + 0x10) < iVar20) goto LAB_0004ac06;
                      iVar20 = *(int *)(iVar19 + 8) - uVar32;
                      if (iVar20 < 0) {
                        iVar20 = -iVar20;
                      }
                      if (*(int *)(iVar19 + 0x14) < iVar20) goto LAB_0004ac06;
                    }
                    iVar28 = iVar28 + 0x18;
                  }
                  iVar22 = iVar22 + 1;
                }
              }
LAB_0004ac52:
            }
          }
          if ((local_48 <= (int)local_f0) && ((int)local_f0 <= param_5)) {
            uVar11 = *puVar24;
            uVar35 = (uVar11 & uVar1) >> (uVar4 & 0xff);
            uVar23 = (uVar11 & uVar7) >> (uVar2 & 0xff);
            uVar32 = (uVar11 & uVar5) >> (uVar10 & 0xff);
            for (iVar21 = 0; iVar21 < iVar9; iVar21 = iVar21 + 1) {
              iVar27 = local_40[0] + iVar21 * 0x18;
              iVar22 = *(int *)(local_40[0] + iVar21 * 0x18) - uVar35;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar27 + 0xc) < iVar22) {
LAB_0004acf6:
                iVar28 = *(int *)(iVar27 + 4) - uVar23;
                iVar27 = *(int *)(iVar27 + 8) - uVar32;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (iVar27 < 0) {
                  iVar27 = -iVar27;
                }
                if (iVar22 + iVar28 + iVar27 <= local_d8) goto LAB_0004ae3c;
              }
              else {
                iVar28 = *(int *)(iVar27 + 4) - uVar23;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (*(int *)(iVar27 + 0x10) < iVar28) goto LAB_0004acf6;
                iVar28 = *(int *)(iVar27 + 8) - uVar32;
                if (iVar28 < 0) {
                  iVar28 = -iVar28;
                }
                if (*(int *)(iVar27 + 0x14) < iVar28) goto LAB_0004acf6;
LAB_0004ae3c:
                iVar22 = 0;
                while( true ) {
                  uVar11 = local_f0;
                  if (iVar25 <= iVar22) goto LAB_0004c452;
                  iVar27 = local_40[3] + iVar22 * 0x18;
                  uVar11 = local_f0 + *(int *)(iVar27 + 0x14);
                  if (iVar15 - 1U < uVar11) break;
                  uVar30 = iVar8 + *(int *)(iVar27 + 0x10);
                  uVar18 = uVar11 >> 0x1f;
                  if (uVar6 < uVar30) {
                    uVar18 = 1;
                  }
                  if ((uVar18 != 0) || ((int)uVar30 < 0)) break;
                  uVar11 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar11 + uVar30));
                  uVar35 = (uVar11 & uVar1) >> (uVar4 & 0xff);
                  uVar23 = (uVar11 & uVar7) >> (uVar2 & 0xff);
                  uVar32 = (uVar11 & uVar5) >> (uVar10 & 0xff);
                  iVar28 = 0;
                  for (iVar33 = 0; iVar33 < *(int *)(local_40[3] + iVar22 * 0x18);
                      iVar33 = iVar33 + 1) {
                    iVar19 = *(int *)(iVar27 + 4) + iVar28;
                    iVar34 = *(int *)(*(int *)(iVar27 + 4) + iVar28) - uVar35;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar19 + 0xc) < iVar34) {
LAB_0004ae02:
                      iVar20 = *(int *)(iVar19 + 4) - uVar23;
                      iVar19 = *(int *)(iVar19 + 8) - uVar32;
                      if (iVar20 < 0) {
                        iVar20 = -iVar20;
                      }
                      if (iVar19 < 0) {
                        iVar19 = -iVar19;
                      }
                      if (local_d8 < iVar34 + iVar20 + iVar19) goto LAB_0004ae4e;
                    }
                    else {
                      iVar20 = *(int *)(iVar19 + 4) - uVar23;
                      if (iVar20 < 0) {
                        iVar20 = -iVar20;
                      }
                      if (*(int *)(iVar19 + 0x10) < iVar20) goto LAB_0004ae02;
                      iVar20 = *(int *)(iVar19 + 8) - uVar32;
                      if (iVar20 < 0) {
                        iVar20 = -iVar20;
                      }
                      if (*(int *)(iVar19 + 0x14) < iVar20) goto LAB_0004ae02;
                    }
                    iVar28 = iVar28 + 0x18;
                  }
                  iVar22 = iVar22 + 1;
                }
              }
LAB_0004ae4e:
            }
          }
        }
        puVar24 = (uint *)((int)puVar24 + iVar13);
      }
      puVar24 = (uint *)(iVar31 + local_78);
      for (; (int)uVar11 <= (int)local_f0; uVar11 = uVar11 + 1) {
        if ((((local_44 <= local_e4) && (local_e4 <= local_4c)) && (local_48 <= (int)uVar11)) &&
           ((int)uVar11 <= param_5)) {
          uVar32 = *(uint *)((int)puVar24 + local_70);
          uVar35 = (uVar32 & uVar1) >> (uVar4 & 0xff);
          uVar23 = (uVar32 & uVar7) >> (uVar2 & 0xff);
          uVar32 = (uVar32 & uVar5) >> (uVar10 & 0xff);
          for (iVar22 = 0; iVar22 < iVar9; iVar22 = iVar22 + 1) {
            iVar27 = local_40[0] + iVar22 * 0x18;
            iVar8 = *(int *)(local_40[0] + iVar22 * 0x18) - uVar35;
            if (iVar8 < 0) {
              iVar8 = -iVar8;
            }
            if (*(int *)(iVar27 + 0xc) < iVar8) {
LAB_0004af38:
              iVar28 = *(int *)(iVar27 + 4) - uVar23;
              iVar27 = *(int *)(iVar27 + 8) - uVar32;
              if (iVar28 < 0) {
                iVar28 = -iVar28;
              }
              if (iVar27 < 0) {
                iVar27 = -iVar27;
              }
              if (iVar8 + iVar28 + iVar27 <= local_d8) goto LAB_0004b07e;
            }
            else {
              iVar28 = *(int *)(iVar27 + 4) - uVar23;
              if (iVar28 < 0) {
                iVar28 = -iVar28;
              }
              if (*(int *)(iVar27 + 0x10) < iVar28) goto LAB_0004af38;
              iVar28 = *(int *)(iVar27 + 8) - uVar32;
              if (iVar28 < 0) {
                iVar28 = -iVar28;
              }
              if (*(int *)(iVar27 + 0x14) < iVar28) goto LAB_0004af38;
LAB_0004b07e:
              iVar27 = 0;
              while( true ) {
                iVar8 = local_e4;
                if (iVar25 <= iVar27) goto LAB_0004c452;
                iVar8 = local_40[3] + iVar27 * 0x18;
                uVar18 = uVar11 + *(int *)(iVar8 + 0x14);
                if (((iVar15 - 1U < uVar18) ||
                    (uVar30 = local_e4 + *(int *)(iVar8 + 0x10), uVar6 < uVar30 || (int)uVar18 < 0))
                   || ((int)uVar30 < 0)) break;
                uVar32 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar18 + uVar30));
                uVar35 = (uVar32 & uVar1) >> (uVar4 & 0xff);
                uVar23 = (uVar32 & uVar7) >> (uVar2 & 0xff);
                uVar32 = (uVar32 & uVar5) >> (uVar10 & 0xff);
                iVar28 = 0;
                for (iVar33 = 0; iVar33 < *(int *)(local_40[3] + iVar27 * 0x18); iVar33 = iVar33 + 1
                    ) {
                  iVar19 = *(int *)(iVar8 + 4) + iVar28;
                  iVar34 = *(int *)(*(int *)(iVar8 + 4) + iVar28) - uVar35;
                  if (iVar34 < 0) {
                    iVar34 = -iVar34;
                  }
                  if (*(int *)(iVar19 + 0xc) < iVar34) {
LAB_0004b044:
                    iVar20 = *(int *)(iVar19 + 4) - uVar23;
                    iVar19 = *(int *)(iVar19 + 8) - uVar32;
                    if (iVar20 < 0) {
                      iVar20 = -iVar20;
                    }
                    if (iVar19 < 0) {
                      iVar19 = -iVar19;
                    }
                    if (local_d8 < iVar34 + iVar20 + iVar19) goto LAB_0004b090;
                  }
                  else {
                    iVar20 = *(int *)(iVar19 + 4) - uVar23;
                    if (iVar20 < 0) {
                      iVar20 = -iVar20;
                    }
                    if (*(int *)(iVar19 + 0x10) < iVar20) goto LAB_0004b044;
                    iVar20 = *(int *)(iVar19 + 8) - uVar32;
                    if (iVar20 < 0) {
                      iVar20 = -iVar20;
                    }
                    if (*(int *)(iVar19 + 0x14) < iVar20) goto LAB_0004b044;
                  }
                  iVar28 = iVar28 + 0x18;
                }
                iVar27 = iVar27 + 1;
              }
            }
LAB_0004b090:
          }
        }
        if (((local_44 <= iVar21) && (iVar21 <= local_4c)) &&
           ((local_48 <= (int)uVar11 && ((int)uVar11 <= param_5)))) {
          uVar32 = *puVar24;
          uVar35 = (uVar32 & uVar1) >> (uVar4 & 0xff);
          uVar23 = (uVar32 & uVar7) >> (uVar2 & 0xff);
          uVar32 = (uVar32 & uVar5) >> (uVar10 & 0xff);
          for (iVar22 = 0; iVar22 < iVar9; iVar22 = iVar22 + 1) {
            iVar27 = local_40[0] + iVar22 * 0x18;
            iVar8 = *(int *)(local_40[0] + iVar22 * 0x18) - uVar35;
            if (iVar8 < 0) {
              iVar8 = -iVar8;
            }
            if (*(int *)(iVar27 + 0xc) < iVar8) {
LAB_0004b140:
              iVar28 = *(int *)(iVar27 + 4) - uVar23;
              iVar27 = *(int *)(iVar27 + 8) - uVar32;
              if (iVar28 < 0) {
                iVar28 = -iVar28;
              }
              if (iVar27 < 0) {
                iVar27 = -iVar27;
              }
              if (iVar8 + iVar28 + iVar27 <= local_d8) goto LAB_0004b286;
            }
            else {
              iVar28 = *(int *)(iVar27 + 4) - uVar23;
              if (iVar28 < 0) {
                iVar28 = -iVar28;
              }
              if (*(int *)(iVar27 + 0x10) < iVar28) goto LAB_0004b140;
              iVar28 = *(int *)(iVar27 + 8) - uVar32;
              if (iVar28 < 0) {
                iVar28 = -iVar28;
              }
              if (*(int *)(iVar27 + 0x14) < iVar28) goto LAB_0004b140;
LAB_0004b286:
              iVar27 = 0;
              while( true ) {
                iVar8 = iVar21;
                if (iVar25 <= iVar27) goto LAB_0004c452;
                iVar8 = local_40[3] + iVar27 * 0x18;
                uVar18 = uVar11 + *(int *)(iVar8 + 0x14);
                if (((iVar15 - 1U < uVar18) ||
                    (uVar30 = iVar21 + *(int *)(iVar8 + 0x10), uVar6 < uVar30 || (int)uVar18 < 0))
                   || ((int)uVar30 < 0)) break;
                uVar32 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar18 + uVar30));
                uVar35 = (uVar32 & uVar1) >> (uVar4 & 0xff);
                uVar23 = (uVar32 & uVar7) >> (uVar2 & 0xff);
                uVar32 = (uVar32 & uVar5) >> (uVar10 & 0xff);
                iVar28 = 0;
                for (iVar33 = 0; iVar33 < *(int *)(local_40[3] + iVar27 * 0x18); iVar33 = iVar33 + 1
                    ) {
                  iVar19 = *(int *)(iVar8 + 4) + iVar28;
                  iVar34 = *(int *)(*(int *)(iVar8 + 4) + iVar28) - uVar35;
                  if (iVar34 < 0) {
                    iVar34 = -iVar34;
                  }
                  if (*(int *)(iVar19 + 0xc) < iVar34) {
LAB_0004b24c:
                    iVar20 = *(int *)(iVar19 + 4) - uVar23;
                    iVar19 = *(int *)(iVar19 + 8) - uVar32;
                    if (iVar20 < 0) {
                      iVar20 = -iVar20;
                    }
                    if (iVar19 < 0) {
                      iVar19 = -iVar19;
                    }
                    if (local_d8 < iVar34 + iVar20 + iVar19) goto LAB_0004b298;
                  }
                  else {
                    iVar20 = *(int *)(iVar19 + 4) - uVar23;
                    if (iVar20 < 0) {
                      iVar20 = -iVar20;
                    }
                    if (*(int *)(iVar19 + 0x10) < iVar20) goto LAB_0004b24c;
                    iVar20 = *(int *)(iVar19 + 8) - uVar32;
                    if (iVar20 < 0) {
                      iVar20 = -iVar20;
                    }
                    if (*(int *)(iVar19 + 0x14) < iVar20) goto LAB_0004b24c;
                  }
                  iVar28 = iVar28 + 0x18;
                }
                iVar27 = iVar27 + 1;
              }
            }
LAB_0004b298:
          }
        }
        puVar24 = (uint *)((int)puVar24 + iVar13 * iVar16);
      }
      local_f0 = local_f0 + 1;
      local_dc = local_dc + -1;
      local_e4 = local_e4 + -1;
      local_78 = local_78 + iVar13 * (1 - iVar16);
      local_70 = local_70 + iVar13 * -2;
      local_6c = local_6c + iVar13 * uVar6;
      local_e8 = local_e8 + iVar13 * iVar16 * -2;
    }
  }
  else {
    iVar8 = local_4c;
    uVar11 = param_5;
    if (iVar29 == 2) {
      local_ec = (uint *)(iVar13 * (iVar16 * param_5 + local_4c) + iVar14);
      for (; local_48 <= (int)uVar11; uVar11 = uVar11 + -1) {
        puVar24 = local_ec;
        for (iVar8 = local_4c; local_44 <= iVar8; iVar8 = iVar8 + -1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004b3d0:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004b532;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004b3d0;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004b3d0;
LAB_0004b532:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (iVar15 - 1U < uVar26) break;
                uVar32 = iVar8 + *(int *)(iVar21 + 0x10);
                uVar23 = uVar26 >> 0x1f;
                if (iVar16 - 1U < uVar32) {
                  uVar23 = 1;
                }
                if ((uVar23 != 0) || ((int)uVar32 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar32));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004b4f4:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004b542;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004b4f4;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004b4f4;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004b542:
          }
          puVar24 = (uint *)((int)puVar24 - iVar13);
        }
        local_ec = (uint *)((int)local_ec + iVar13 * -iVar16);
      }
    }
    else if (iVar29 == 3) {
      local_ec = (uint *)(iVar13 * (iVar16 * param_5 + local_44) + iVar14);
      for (; local_48 <= (int)uVar11; uVar11 = uVar11 + -1) {
        puVar24 = local_ec;
        for (iVar8 = local_44; iVar8 <= local_4c; iVar8 = iVar8 + 1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004b64e:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004b7b0;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004b64e;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004b64e;
LAB_0004b7b0:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (iVar15 - 1U < uVar26) break;
                uVar32 = iVar8 + *(int *)(iVar21 + 0x10);
                uVar23 = uVar26 >> 0x1f;
                if (iVar16 - 1U < uVar32) {
                  uVar23 = 1;
                }
                if ((uVar23 != 0) || ((int)uVar32 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar32));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004b772:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004b7c0;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004b772;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004b772;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004b7c0:
          }
          puVar24 = (uint *)((int)puVar24 + iVar13);
        }
        local_ec = (uint *)((int)local_ec + iVar13 * -iVar16);
      }
    }
    else if (iVar29 == 4) {
      local_ec = (uint *)(iVar13 * (iVar16 * local_48 + local_4c) + iVar14);
      for (uVar11 = local_48; (int)uVar11 <= param_5; uVar11 = uVar11 + 1) {
        puVar24 = local_ec;
        for (iVar8 = local_4c; local_44 <= iVar8; iVar8 = iVar8 + -1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004b8ca:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004ba2c;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004b8ca;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004b8ca;
LAB_0004ba2c:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (iVar15 - 1U < uVar26) break;
                uVar32 = iVar8 + *(int *)(iVar21 + 0x10);
                uVar23 = uVar26 >> 0x1f;
                if (iVar16 - 1U < uVar32) {
                  uVar23 = 1;
                }
                if ((uVar23 != 0) || ((int)uVar32 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar32));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004b9ee:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004ba3c;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004b9ee;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004b9ee;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004ba3c:
          }
          puVar24 = (uint *)((int)puVar24 - iVar13);
        }
        local_ec = (uint *)((int)local_ec + iVar16 * iVar13);
      }
    }
    else if (iVar29 == 5) {
      local_ec = (uint *)(iVar13 * (iVar16 * local_48 + local_44) + iVar14);
      for (iVar8 = local_44; iVar8 <= local_4c; iVar8 = iVar8 + 1) {
        puVar24 = local_ec;
        for (uVar11 = local_48; (int)uVar11 <= param_5; uVar11 = uVar11 + 1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004bb5c:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004bcb4;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004bb5c;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004bb5c;
LAB_0004bcb4:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (((iVar15 - 1U < uVar26) ||
                    (uVar23 = iVar8 + *(int *)(iVar21 + 0x10),
                    iVar16 - 1U < uVar23 || (int)uVar26 < 0)) || ((int)uVar23 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar23));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004bc76:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004bcc2;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004bc76;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004bc76;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004bcc2:
          }
          puVar24 = (uint *)((int)puVar24 + iVar16 * iVar13);
        }
        local_ec = (uint *)((int)local_ec + iVar13);
      }
    }
    else if (iVar29 == 6) {
      local_ec = (uint *)(iVar13 * (iVar16 * local_48 + local_4c) + iVar14);
      for (; local_44 <= iVar8; iVar8 = iVar8 + -1) {
        puVar24 = local_ec;
        for (uVar11 = local_48; (int)uVar11 <= param_5; uVar11 = uVar11 + 1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004bdd0:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004bf28;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004bdd0;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004bdd0;
LAB_0004bf28:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (((iVar15 - 1U < uVar26) ||
                    (uVar23 = iVar8 + *(int *)(iVar21 + 0x10),
                    iVar16 - 1U < uVar23 || (int)uVar26 < 0)) || ((int)uVar23 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar23));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004beea:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004bf36;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004beea;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004beea;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004bf36:
          }
          puVar24 = (uint *)((int)puVar24 + iVar16 * iVar13);
        }
        local_ec = (uint *)((int)local_ec - iVar13);
      }
    }
    else if (iVar29 == 7) {
      local_ec = (uint *)(iVar13 * (iVar16 * param_5 + local_44) + iVar14);
      for (iVar8 = local_44; iVar8 <= local_4c; iVar8 = iVar8 + 1) {
        puVar24 = local_ec;
        for (uVar11 = param_5; local_48 <= (int)uVar11; uVar11 = uVar11 + -1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004c044:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004c19c;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004c044;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004c044;
LAB_0004c19c:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (((iVar15 - 1U < uVar26) ||
                    (uVar23 = iVar8 + *(int *)(iVar21 + 0x10),
                    iVar16 - 1U < uVar23 || (int)uVar26 < 0)) || ((int)uVar23 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar23));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004c15e:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004c1aa;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004c15e;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004c15e;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004c1aa:
          }
          puVar24 = (uint *)((int)puVar24 + iVar13 * -iVar16);
        }
        local_ec = (uint *)((int)local_ec + iVar13);
      }
    }
    else if (iVar29 == 8) {
      local_ec = (uint *)(iVar13 * (iVar16 * param_5 + local_4c) + iVar14);
      for (; local_44 <= iVar8; iVar8 = iVar8 + -1) {
        puVar24 = local_ec;
        for (uVar11 = param_5; local_48 <= (int)uVar11; uVar11 = uVar11 + -1) {
          uVar6 = *puVar24;
          local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
          uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
          uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
          for (iVar29 = 0; iVar29 < iVar9; iVar29 = iVar29 + 1) {
            iVar21 = local_40[0] + iVar29 * 0x18;
            iVar31 = *(int *)(local_40[0] + iVar29 * 0x18) - local_f0;
            if (iVar31 < 0) {
              iVar31 = -iVar31;
            }
            if (*(int *)(iVar21 + 0xc) < iVar31) {
LAB_0004c2b6:
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              iVar21 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (iVar21 < 0) {
                iVar21 = -iVar21;
              }
              if (iVar31 + iVar22 + iVar21 <= local_d8) goto LAB_0004c40e;
            }
            else {
              iVar22 = *(int *)(iVar21 + 4) - uVar3;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x10) < iVar22) goto LAB_0004c2b6;
              iVar22 = *(int *)(iVar21 + 8) - uVar6;
              if (iVar22 < 0) {
                iVar22 = -iVar22;
              }
              if (*(int *)(iVar21 + 0x14) < iVar22) goto LAB_0004c2b6;
LAB_0004c40e:
              iVar31 = 0;
              while( true ) {
                if (iVar25 <= iVar31) goto LAB_0004c452;
                iVar21 = local_40[3] + iVar31 * 0x18;
                uVar26 = uVar11 + *(int *)(iVar21 + 0x14);
                if (((iVar15 - 1U < uVar26) ||
                    (uVar23 = iVar8 + *(int *)(iVar21 + 0x10),
                    iVar16 - 1U < uVar23 || (int)uVar26 < 0)) || ((int)uVar23 < 0)) break;
                uVar6 = *(uint *)(iVar14 + iVar13 * (iVar16 * uVar26 + uVar23));
                local_f0 = (uVar6 & uVar1) >> (uVar4 & 0xff);
                uVar3 = (uVar6 & uVar7) >> (uVar2 & 0xff);
                uVar6 = (uVar6 & uVar5) >> (uVar10 & 0xff);
                iVar22 = 0;
                for (iVar27 = 0; iVar27 < *(int *)(local_40[3] + iVar31 * 0x18); iVar27 = iVar27 + 1
                    ) {
                  iVar33 = *(int *)(iVar21 + 4) + iVar22;
                  iVar28 = *(int *)(*(int *)(iVar21 + 4) + iVar22) - local_f0;
                  if (iVar28 < 0) {
                    iVar28 = -iVar28;
                  }
                  if (*(int *)(iVar33 + 0xc) < iVar28) {
LAB_0004c3d0:
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    iVar33 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar33 < 0) {
                      iVar33 = -iVar33;
                    }
                    if (local_d8 < iVar28 + iVar34 + iVar33) goto LAB_0004c41c;
                  }
                  else {
                    iVar34 = *(int *)(iVar33 + 4) - uVar3;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x10) < iVar34) goto LAB_0004c3d0;
                    iVar34 = *(int *)(iVar33 + 8) - uVar6;
                    if (iVar34 < 0) {
                      iVar34 = -iVar34;
                    }
                    if (*(int *)(iVar33 + 0x14) < iVar34) goto LAB_0004c3d0;
                  }
                  iVar22 = iVar22 + 0x18;
                }
                iVar31 = iVar31 + 1;
              }
            }
LAB_0004c41c:
          }
          puVar24 = (uint *)((int)puVar24 + iVar13 * -iVar16);
        }
        local_ec = (uint *)((int)local_ec - iVar13);
      }
    }
  }
LAB_0004c45e:
  FUN_0003bd6e(local_40 + 3);
  FUN_0003bb8c(local_40);
  return;
LAB_0004c452:
  *param_10 = iVar8;
  *param_11 = uVar11;
  goto LAB_0004c45e;
}



