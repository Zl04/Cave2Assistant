/* Fixed Thumb JNI Run functions: libmqm.so */

/* ============================================================ */
/* Java_com_cyjh_mqm_MQLanguageStub_Run__Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2IJ @ 00033d7c */

void Java_com_cyjh_mqm_MQLanguageStub_Run__Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2IJ
               (undefined4 param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4,
               undefined4 param_5)

{
  undefined4 local_34 [2];
  undefined4 *local_2c;
  undefined1 *local_28;
  undefined1 *local_24;
  undefined1 *local_20;
  
  local_28 = &stack0x00000004;
  local_2c = local_34;
  local_24 = &stack0x00000008;
  local_20 = &stack0x0000000c;
  local_34[0] = param_1;
  FUN_00033bec(param_1,param_2,param_3,param_4,param_5,local_2c,local_28,local_24,local_20,
               &stack0x00000010);
  return;
}



/* ============================================================ */
/* Java_com_cyjh_mqm_MQLanguageStub_Run___3BLjava_lang_String_2Ljava_lang_String_2IIJ @ 00033f34 */

void Java_com_cyjh_mqm_MQLanguageStub_Run___3BLjava_lang_String_2Ljava_lang_String_2IIJ
               (undefined4 param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4,
               undefined4 param_5,undefined4 param_6,int param_7)

{
  int iVar1;
  int iVar2;
  int iVar3;
  
  iVar1 = param_7;
  iVar3 = 0;
  while ((iVar3 < iVar1 || iVar1 < 1 &&
         (iVar2 = FUN_00033dc0(param_1,param_2,param_3,param_4,param_5,&param_6,&stack0x00000010),
         iVar2 == 0))) {
    iVar3 = iVar3 + 1;
  }
  return;
}



/* ============================================================ */
/* Java_com_cyjh_mqm_MQLanguageStub_Run__Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2IIJ @ 000340dc */

void Java_com_cyjh_mqm_MQLanguageStub_Run__Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2IIJ
               (undefined4 param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4,
               undefined4 param_5,undefined4 param_6,int param_7)

{
  int iVar1;
  int iVar2;
  int iVar3;
  
  iVar1 = param_7;
  iVar3 = 0;
  while ((iVar3 < iVar1 || iVar1 < 1 &&
         (iVar2 = FUN_00033f94(param_1,param_2,param_3,param_4,param_5,&param_6,&stack0x00000010),
         iVar2 == 0))) {
    iVar3 = iVar3 + 1;
  }
  return;
}



