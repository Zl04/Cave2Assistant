
/* === setPvrEncryptionKeyPart @ 00fb5528 === */

/* cocos2d::ZipUtils::setPvrEncryptionKeyPart(int, unsigned int) */

void cocos2d::ZipUtils::setPvrEncryptionKeyPart(int param_1,uint param_2)

{
  if (*(uint *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + (long)param_1 * 4) != param_2) {
    *(uint *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + (long)param_1 * 4) = param_2;
    *PTR_s_bEncryptionKeyIsValid_0171a260 = 0;
  }
  return;
}


/* === inflateCCZBuffer @ 00fb4b40 === */

/* cocos2d::ZipUtils::inflateCCZBuffer(unsigned char const*, long, unsigned char**) */

void cocos2d::ZipUtils::inflateCCZBuffer(uchar *param_1,long param_2,uchar **param_3)

{
  int *piVar1;
  uint uVar2;
  uint uVar3;
  char cVar4;
  undefined *puVar5;
  ulong uVar6;
  bool bVar7;
  int iVar8;
  undefined4 uVar9;
  uchar *puVar10;
  long *plVar11;
  uint uVar12;
  uint *puVar13;
  uint uVar14;
  uint *puVar15;
  uint uVar16;
  int iVar17;
  code *pcVar18;
  long lVar19;
  undefined1 auStack_20 [8];
  long local_18;
  ulong local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (*(int *)param_1 == 0x215a4343) {
    if (DAT_0136b760 < 0x100) {
      if ((*(ushort *)(param_1 + 6) < 3) && (*(short *)(param_1 + 4) == 0)) {
LAB_00fb4e14:
        uVar16 = *(uint *)(param_1 + 0xc);
LAB_00fb4d68:
        puVar10 = (uchar *)malloc((ulong)uVar16);
        *param_3 = puVar10;
        if (puVar10 != (uchar *)0x0) {
          local_10 = (ulong)uVar16;
          iVar8 = uncompress(puVar10,&local_10,param_1 + 0x10,param_2 + -0x10);
          if (iVar8 == 0) goto LAB_00fb4d94;
          free(*param_3);
          *param_3 = (uchar *)0x0;
        }
      }
    }
    else if ((ushort)(*(ushort *)(param_1 + 6) << 8 | *(ushort *)(param_1 + 6) >> 8) < 3) {
      if ((*(ushort *)(param_1 + 4) & 0xff) != 0 || *(ushort *)(param_1 + 4) >> 8 != 0) {
        uVar16 = 0xffffffff;
        goto LAB_00fb4d94;
      }
LAB_00fb4d60:
      uVar16 = (*(uint *)(param_1 + 0xc) & 0xff00ff00) >> 8 |
               (*(uint *)(param_1 + 0xc) & 0xff00ff) << 8;
      uVar16 = uVar16 >> 0x10 | uVar16 << 0x10;
      goto LAB_00fb4d68;
    }
  }
  else if (*(int *)param_1 == 0x705a4343) {
    if (DAT_0136b760 < 0x100) {
      if (*(short *)(param_1 + 6) == 0) {
        bVar7 = *(short *)(param_1 + 4) != 0;
LAB_00fb4bc0:
        if (!bVar7) {
          lVar19 = param_2 + -9;
          if (-1 < param_2 + -0xc) {
            lVar19 = param_2 + -0xc;
          }
          puVar13 = (uint *)(param_1 + 0xc);
          lVar19 = lVar19 >> 2;
          if (*(int *)PTR_s_uEncryptedPvrKeyParts_01713d98 == 0) {
            plVar11 = (long *)FileUtils::getInstance();
                    /* try { // try from 00fb50a4 to 010b50a7 has its CatchHandler @ 00fb5128 */
            pcVar18 = *(code **)(*plVar11 + 0x1e0);
            FUN_01211570(&local_18,"1040223501",auStack_20);
            (*pcVar18)(&local_10,plVar11,&local_18);
            uVar6 = local_10;
            uVar9 = atoll(local_10);
            puVar5 = PTR_DAT_017191c0;
                    /* try { // try from 00fb50d4 to 010b513f has its CatchHandler @ 00fb5070 */
            *(undefined4 *)PTR_s_uEncryptedPvrKeyParts_01713d98 = uVar9;
            if ((undefined *)(uVar6 - 0x18) != puVar5) {
              piVar1 = (int *)(uVar6 - 8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(uVar6 - 8);
                    /* try { // try from 00fb52dc to 010b52df has its CatchHandler @ 00fb5328 */
                *(int *)(uVar6 - 8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
              if (iVar8 < 1) {
                operator_delete((undefined *)(uVar6 - 0x18));
              }
            }
            if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
              piVar1 = (int *)(local_18 + -8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(local_18 + -8);
                *(int *)(local_18 + -8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
                    /* catch() { ... } // from try @ 00fb50a4 with catch @ 00fb5128 */
              if (iVar8 < 1) {
                operator_delete((undefined *)(local_18 + -0x18));
              }
            }
          }
          if (*(int *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + 4) == 0) {
            plVar11 = (long *)FileUtils::getInstance();
            pcVar18 = *(code **)(*plVar11 + 0x1e0);
            FUN_01211570(&local_18,"7472852033",auStack_20);
            (*pcVar18)(&local_10,plVar11,&local_18);
            uVar6 = local_10;
            uVar9 = atoll(local_10);
            puVar5 = PTR_DAT_017191c0;
            *(undefined4 *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + 4) = uVar9;
            if ((undefined *)(uVar6 - 0x18) != puVar5) {
              piVar1 = (int *)(uVar6 - 8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 00fb53d0 with catch @ 00fb5378 */
                iVar8 = *(int *)(uVar6 - 8);
                *(int *)(uVar6 - 8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
              if (iVar8 < 1) {
                operator_delete((undefined *)(uVar6 - 0x18));
              }
            }
            if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
              piVar1 = (int *)(local_18 + -8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(local_18 + -8);
                *(int *)(local_18 + -8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
                    /* catch() { ... } // from try @ 00fb50d4 with catch @ 00fb5070 */
              if (iVar8 < 1) {
                operator_delete((undefined *)(local_18 + -0x18));
              }
            }
          }
          if (*(int *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + 8) == 0) {
            plVar11 = (long *)FileUtils::getInstance();
                    /* catch() { ... } // from try @ 00fb4e9c with catch @ 00fb4f20 */
            pcVar18 = *(code **)(*plVar11 + 0x1e0);
            FUN_01211570(&local_18,"148122488",auStack_20);
            (*pcVar18)(&local_10,plVar11,&local_18);
            uVar6 = local_10;
            uVar9 = atoll(local_10);
            puVar5 = PTR_DAT_017191c0;
            *(undefined4 *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + 8) = uVar9;
            if ((undefined *)(uVar6 - 0x18) != puVar5) {
              piVar1 = (int *)(uVar6 - 8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(uVar6 - 8);
                *(int *)(uVar6 - 8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
              if (iVar8 < 1) {
                operator_delete((undefined *)(uVar6 - 0x18));
              }
            }
            if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
              piVar1 = (int *)(local_18 + -8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(local_18 + -8);
                *(int *)(local_18 + -8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
              if (iVar8 < 1) {
                operator_delete((undefined *)(local_18 + -0x18));
              }
            }
          }
          if (*(int *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + 0xc) == 0) {
            plVar11 = (long *)FileUtils::getInstance();
                    /* catch() { ... } // from try @ 00fb4ecc with catch @ 00fb4e68 */
            pcVar18 = *(code **)(*plVar11 + 0x1e0);
            FUN_01211570(&local_18,"2340785181",auStack_20);
                    /* try { // try from 00fb4e9c to 010b4e9f has its CatchHandler @ 00fb4f20 */
            (*pcVar18)(&local_10,plVar11,&local_18);
            uVar6 = local_10;
            uVar9 = atoll(local_10);
            puVar5 = PTR_DAT_017191c0;
            *(undefined4 *)(PTR_s_uEncryptedPvrKeyParts_01713d98 + 0xc) = uVar9;
            if ((undefined *)(uVar6 - 0x18) != puVar5) {
              piVar1 = (int *)(uVar6 - 8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(uVar6 - 8);
                    /* try { // try from 00fb53a4 to 010b53a7 has its CatchHandler @ 00fb541c */
                *(int *)(uVar6 - 8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
              if (iVar8 < 1) {
                operator_delete((undefined *)(uVar6 - 0x18));
              }
            }
                    /* try { // try from 00fb4ecc to 010b4f37 has its CatchHandler @ 00fb4e68 */
            if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
              piVar1 = (int *)(local_18 + -8);
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar8 = *(int *)(local_18 + -8);
                *(int *)(local_18 + -8) = iVar8 + -1;
              }
              else {
                do {
                  iVar8 = *piVar1;
                  cVar4 = '\x01';
                  bVar7 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                  if (bVar7) {
                    *piVar1 = iVar8 + -1;
                    cVar4 = ExclusiveMonitorsStatus();
                  }
                } while (cVar4 != '\0');
              }
              if (iVar8 < 1) {
                operator_delete((undefined *)(local_18 + -0x18));
              }
            }
          }
          if (*PTR_s_bEncryptionKeyIsValid_0171a260 == '\0') {
            uVar16 = 0;
            uVar12 = *(uint *)(PTR_s_uEncryptionKey_0171cef8 + 0xffc);
            do {
              uVar14 = 0;
              uVar16 = uVar16 + 0x9e3779b9;
              puVar15 = (uint *)PTR_s_uEncryptionKey_0171cef8;
              do {
                puVar5 = PTR_s_uEncryptedPvrKeyParts_01713d98;
                uVar2 = uVar14 ^ uVar16 >> 2;
                uVar3 = puVar15[1];
                    /* catch() { ... } // from try @ 00fb4cc4 with catch @ 00fb4c60 */
                uVar14 = uVar14 + 1;
                uVar12 = ((uVar12 ^ *(uint *)(PTR_s_uEncryptedPvrKeyParts_01713d98 +
                                             (ulong)(uVar2 & 3) * 4)) + (uVar3 ^ uVar16) ^
                         (uVar12 << 4 ^ uVar3 >> 3) + (uVar12 >> 5 ^ uVar3 << 2)) + *puVar15;
                    /* try { // try from 00fb4c94 to 010b4c97 has its CatchHandler @ 00fb4d18 */
                *puVar15 = uVar12;
                puVar15 = puVar15 + 1;
              } while (uVar14 != 0x3ff);
              uVar14 = *(uint *)PTR_s_uEncryptionKey_0171cef8;
                    /* try { // try from 00fb4cc4 to 010b4d2f has its CatchHandler @ 00fb4c60 */
              uVar12 = ((uVar14 >> 3 ^ uVar12 * 0x10) + (uVar14 << 2 ^ uVar12 >> 5) ^
                       (uVar12 ^ *(uint *)(puVar5 + (ulong)((uVar16 >> 2 ^ 0x3ff) & 3) * 4)) +
                       (uVar16 ^ uVar14)) + *(int *)(PTR_s_uEncryptionKey_0171cef8 + 0xffc);
              *(uint *)(PTR_s_uEncryptionKey_0171cef8 + 0xffc) = uVar12;
            } while (uVar16 != 0xb54cda56);
            *PTR_s_bEncryptionKeyIsValid_0171a260 = 1;
          }
          if (0 < lVar19) {
            iVar8 = 0;
                    /* catch() { ... } // from try @ 00fb4c94 with catch @ 00fb4d18 */
            do {
              iVar17 = iVar8 + 1;
              if (0x3ff < iVar17) {
                iVar17 = 0;
              }
              *puVar13 = *puVar13 ^ *(uint *)(PTR_s_uEncryptionKey_0171cef8 + (long)iVar8 * 4);
              if (puVar13 == (uint *)(param_1 + (lVar19 + 2) * 4)) goto joined_r0x00fb5188;
              puVar13 = puVar13 + 1;
              iVar8 = iVar17;
            } while (puVar13 != (uint *)(param_1 + 0x80c));
            if (0x200 < lVar19) {
              puVar13 = (uint *)(param_1 + 0x80c);
              do {
                puVar15 = puVar13 + 0x40;
                iVar8 = iVar17 + 1;
                if (0x3ff < iVar8) {
                  iVar8 = 0;
                }
                *puVar13 = *puVar13 ^ *(uint *)(PTR_s_uEncryptionKey_0171cef8 + (long)iVar17 * 4);
                puVar13 = puVar15;
                iVar17 = iVar8;
              } while (puVar15 != (uint *)(param_1 + (lVar19 - 0x201U >> 6) * 0x100 + 0x90c));
            }
          }
joined_r0x00fb5188:
          if (DAT_0136b760 < 0x100) goto LAB_00fb4e14;
          goto LAB_00fb4d60;
        }
      }
    }
    else if ((*(ushort *)(param_1 + 6) & 0xff) == 0 && *(ushort *)(param_1 + 6) >> 8 == 0) {
      bVar7 = (*(ushort *)(param_1 + 4) & 0xff) != 0 || *(ushort *)(param_1 + 4) >> 8 != 0;
      goto LAB_00fb4bc0;
    }
  }
  uVar16 = 0xffffffff;
LAB_00fb4d94:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar16);
  }
  return;
}

