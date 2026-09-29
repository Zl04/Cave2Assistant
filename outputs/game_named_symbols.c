
/* SYMBOL Avalon::MapGrid::positionToCoordinate @ 007f0244 type=Function */

/* Avalon::MapGrid::positionToCoordinate(int, int, int, int) */

void __thiscall
Avalon::MapGrid::positionToCoordinate(MapGrid *this,int param_1,int param_2,int param_3,int param_4)

{
  int iVar1;
  int iVar2;
  float *in_x8;
  
                    /* try { // try from 007f0254 to 008f0257 has its CatchHandler @ 007f28ec */
  iVar1 = 0;
  if ((int)((double)param_2 * 0.5) != 0) {
    iVar1 = (int)this / (int)((double)param_2 * 0.5);
  }
  iVar2 = 0;
  if ((int)((double)param_3 * 0.5) != 0) {
    iVar2 = param_1 / (int)((double)param_3 * 0.5);
  }
                    /* try { // try from 007f026c to 008f026f has its CatchHandler @ 007f28e0 */
                    /* try { // try from 007f0284 to 008f0287 has its CatchHandler @ 007f28d4 */
  *in_x8 = (float)((iVar1 + iVar2) / 2);
  in_x8[1] = (float)((iVar2 - iVar1) / 2);
  return;
}


/* SYMBOL _ZN6Avalon7MapGrid20positionToCoordinateEiiii @ 007f0244 type=Label */

/* Avalon::MapGrid::positionToCoordinate(int, int, int, int) */

void __thiscall
Avalon::MapGrid::positionToCoordinate(MapGrid *this,int param_1,int param_2,int param_3,int param_4)

{
  int iVar1;
  int iVar2;
  float *in_x8;
  
                    /* try { // try from 007f0254 to 008f0257 has its CatchHandler @ 007f28ec */
  iVar1 = 0;
  if ((int)((double)param_2 * 0.5) != 0) {
    iVar1 = (int)this / (int)((double)param_2 * 0.5);
  }
  iVar2 = 0;
  if ((int)((double)param_3 * 0.5) != 0) {
    iVar2 = param_1 / (int)((double)param_3 * 0.5);
  }
                    /* try { // try from 007f026c to 008f026f has its CatchHandler @ 007f28e0 */
                    /* try { // try from 007f0284 to 008f0287 has its CatchHandler @ 007f28d4 */
  *in_x8 = (float)((iVar1 + iVar2) / 2);
  in_x8[1] = (float)((iVar2 - iVar1) / 2);
  return;
}


/* SYMBOL Avalon::MapGrid::coordinateToPosition @ 007f0298 type=Function */

/* Avalon::MapGrid::coordinateToPosition(int, int, int, int) */

void __thiscall
Avalon::MapGrid::coordinateToPosition(MapGrid *this,int param_1,int param_2,int param_3,int param_4)

{
  float *in_x8;
  
                    /* try { // try from 007f029c to 008f029f has its CatchHandler @ 007f28c8 */
                    /* try { // try from 007f02b4 to 008f02b7 has its CatchHandler @ 007f28bc */
                    /* try { // try from 007f02cc to 008f02cf has its CatchHandler @ 007f28b0 */
  *in_x8 = (float)(int)((double)(((int)this - param_1) * param_2) * 0.5);
  in_x8[1] = (float)(int)((double)(((int)this + param_1) * param_3) * 0.5);
  return;
}


/* SYMBOL _ZN6Avalon7MapGrid20coordinateToPositionEiiii @ 007f0298 type=Label */

/* Avalon::MapGrid::coordinateToPosition(int, int, int, int) */

void __thiscall
Avalon::MapGrid::coordinateToPosition(MapGrid *this,int param_1,int param_2,int param_3,int param_4)

{
  float *in_x8;
  
                    /* try { // try from 007f029c to 008f029f has its CatchHandler @ 007f28c8 */
                    /* try { // try from 007f02b4 to 008f02b7 has its CatchHandler @ 007f28bc */
                    /* try { // try from 007f02cc to 008f02cf has its CatchHandler @ 007f28b0 */
  *in_x8 = (float)(int)((double)(((int)this - param_1) * param_2) * 0.5);
  in_x8[1] = (float)(int)((double)(((int)this + param_1) * param_3) * 0.5);
  return;
}


/* SYMBOL Avalon::MapGrid::getPixelPerComponent @ 007f02dc type=Function */

/* Avalon::MapGrid::getPixelPerComponent(cocos2d::Image*) */

int Avalon::MapGrid::getPixelPerComponent(Image *param_1)

{
  int iVar1;
  int iVar2;
  
                    /* try { // try from 007f02e4 to 008f02e7 has its CatchHandler @ 007f28a4 */
  iVar2 = cocos2d::Image::getBitPerPixel(param_1);
  iVar1 = iVar2 + 7;
  if (-1 < iVar2) {
    iVar1 = iVar2;
  }
                    /* try { // try from 007f02fc to 008f02ff has its CatchHandler @ 007f2898 */
  return iVar1 >> 3;
}


/* SYMBOL _ZN6Avalon7MapGrid20getPixelPerComponentEPN7cocos2d5ImageE @ 007f02dc type=Label */

/* Avalon::MapGrid::getPixelPerComponent(cocos2d::Image*) */

int Avalon::MapGrid::getPixelPerComponent(Image *param_1)

{
  int iVar1;
  int iVar2;
  
                    /* try { // try from 007f02e4 to 008f02e7 has its CatchHandler @ 007f28a4 */
  iVar2 = cocos2d::Image::getBitPerPixel(param_1);
  iVar1 = iVar2 + 7;
  if (-1 < iVar2) {
    iVar1 = iVar2;
  }
                    /* try { // try from 007f02fc to 008f02ff has its CatchHandler @ 007f2898 */
  return iVar1 >> 3;
}


/* SYMBOL Avalon::MapGrid::getPixelBytes @ 007f0300 type=Function */

/* Avalon::MapGrid::getPixelBytes(cocos2d::Image*, int, int, unsigned char*) */

void Avalon::MapGrid::getPixelBytes(Image *param_1,int param_2,int param_3,uchar *param_4)

{
  long lVar1;
  int iVar2;
  int iVar3;
  long lVar4;
  
  iVar2 = *(int *)(param_1 + 0x38);
                    /* try { // try from 007f0314 to 008f0317 has its CatchHandler @ 007f288c */
  iVar3 = getPixelPerComponent(param_1);
                    /* try { // try from 007f032c to 008f032f has its CatchHandler @ 007f2880 */
  lVar4 = 0;
                    /* try { // try from 007f0344 to 008f0347 has its CatchHandler @ 007f2874 */
  if (0 < iVar3) {
    do {
      lVar1 = lVar4 + iVar3 * (param_2 + iVar2 * param_3);
      if (lVar1 < *(long *)(param_1 + 0x30)) {
                    /* try { // try from 007f035c to 008f035f has its CatchHandler @ 007f2868 */
        param_4[lVar4] = *(uchar *)(*(long *)(param_1 + 0x28) + lVar1);
      }
      lVar4 = lVar4 + 1;
    } while ((int)lVar4 < iVar3);
  }
                    /* try { // try from 007f0374 to 008f0377 has its CatchHandler @ 007f285c */
  return;
}


/* SYMBOL _ZN6Avalon7MapGrid13getPixelBytesEPN7cocos2d5ImageEiiPh @ 007f0300 type=Label */

/* Avalon::MapGrid::getPixelBytes(cocos2d::Image*, int, int, unsigned char*) */

void Avalon::MapGrid::getPixelBytes(Image *param_1,int param_2,int param_3,uchar *param_4)

{
  long lVar1;
  int iVar2;
  int iVar3;
  long lVar4;
  
  iVar2 = *(int *)(param_1 + 0x38);
                    /* try { // try from 007f0314 to 008f0317 has its CatchHandler @ 007f288c */
  iVar3 = getPixelPerComponent(param_1);
                    /* try { // try from 007f032c to 008f032f has its CatchHandler @ 007f2880 */
  lVar4 = 0;
                    /* try { // try from 007f0344 to 008f0347 has its CatchHandler @ 007f2874 */
  if (0 < iVar3) {
    do {
      lVar1 = lVar4 + iVar3 * (param_2 + iVar2 * param_3);
      if (lVar1 < *(long *)(param_1 + 0x30)) {
                    /* try { // try from 007f035c to 008f035f has its CatchHandler @ 007f2868 */
        param_4[lVar4] = *(uchar *)(*(long *)(param_1 + 0x28) + lVar1);
      }
      lVar4 = lVar4 + 1;
    } while ((int)lVar4 < iVar3);
  }
                    /* try { // try from 007f0374 to 008f0377 has its CatchHandler @ 007f285c */
  return;
}


/* SYMBOL Avalon::MapGrid::saveMapGridToFile @ 007f037c type=Function */

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


/* SYMBOL _ZN6Avalon7MapGrid17saveMapGridToFileEPcRSs @ 007f037c type=Label */

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


/* SYMBOL Avalon::MapGrid::parse @ 007f0554 type=Function */

/* Avalon::MapGrid::parse(std::string const&) */

void Avalon::MapGrid::parse(string *param_1)

{
  uint uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  char cVar5;
  Image *this;
  void *pvVar6;
  int in_w4;
  int iVar7;
  MapGrid *this_00;
  float local_18;
  float local_14;
  byte local_10;
  byte local_f;
  byte local_e;
  char local_d;
  long local_8;
  
  iVar2 = DAT_0172500c;
                    /* try { // try from 007f0554 to 008f0557 has its CatchHandler @ 007f276c */
  iVar4 = DAT_01725008;
                    /* try { // try from 007f056c to 008f056f has its CatchHandler @ 007f2760 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 007f0584 to 008f0587 has its CatchHandler @ 007f2754 */
                    /* try { // try from 007f059c to 008f059f has its CatchHandler @ 007f2748 */
  this = operator_new(0x160);
  cocos2d::Image::Image(this);
                    /* try { // try from 007f05b4 to 008f05b7 has its CatchHandler @ 007f273c */
  cVar5 = cocos2d::Image::initWithImageFile(this,param_1);
  if (cVar5 == '\0') {
    pvVar6 = (void *)0x0;
  }
  else {
                    /* try { // try from 007f05cc to 008f05cf has its CatchHandler @ 007f2730 */
    iVar3 = DAT_0172500c * DAT_01725008;
                    /* try { // try from 007f05e4 to 008f05e7 has its CatchHandler @ 007f2724 */
    pvVar6 = operator_new__((long)(iVar3 + 1));
    memset(pvVar6,0x31,(long)iVar3);
                    /* try { // try from 007f05fc to 008f05ff has its CatchHandler @ 007f2718 */
    if (0 < DAT_01725008) {
      iVar7 = 0;
      if (iVar4 < iVar2) {
        iVar2 = iVar4;
      }
                    /* try { // try from 007f0614 to 008f0617 has its CatchHandler @ 007f270c */
      do {
                    /* try { // try from 007f062c to 008f062f has its CatchHandler @ 007f2700 */
        if (0 < DAT_0172500c) {
          this_00 = (MapGrid *)0x0;
          do {
            iVar4 = DAT_0172500c;
                    /* try { // try from 007f0644 to 008f0647 has its CatchHandler @ 007f26f4 */
            coordinateToPosition(this_00,iVar7,0x2c,0x16,in_w4);
                    /* try { // try from 007f065c to 008f065f has its CatchHandler @ 007f26e8 */
                    /* try { // try from 007f0674 to 008f0677 has its CatchHandler @ 007f26dc */
            local_14 = ((float)*(int *)(this + 0x3c) - local_14) - 11.0;
            local_18 = (float)(int)((double)(iVar2 * 0x2c) * 0.5) + local_18;
                    /* try { // try from 007f068c to 008f068f has its CatchHandler @ 007f26d0 */
            getPixelBytes(this,(int)local_18,(int)local_14,&local_10);
                    /* try { // try from 007f06a4 to 008f06a7 has its CatchHandler @ 007f26c4 */
                    /* try { // try from 007f06bc to 008f06bf has its CatchHandler @ 007f26b8 */
            if ((((0xfa < local_10) && (0xfa < local_f)) && (0xfa < local_e)) && (local_d != '\0'))
            {
              *(undefined1 *)((long)pvVar6 + (long)((int)this_00 + iVar7 * iVar4)) = 0x30;
            }
                    /* try { // try from 007f06d4 to 008f06d7 has its CatchHandler @ 007f26ac */
            uVar1 = (int)this_00 + 1;
            this_00 = (MapGrid *)(ulong)uVar1;
          } while ((int)uVar1 < DAT_0172500c);
        }
        iVar7 = iVar7 + 1;
                    /* try { // try from 007f06ec to 008f06ef has its CatchHandler @ 007f26a0 */
      } while (iVar7 < DAT_01725008);
    }
    *(undefined1 *)((long)pvVar6 + (long)iVar3) = 0;
  }
                    /* try { // try from 007f0704 to 008f0707 has its CatchHandler @ 007f2694 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 007f071c to 008f071f has its CatchHandler @ 007f2688 */
                    /* try { // try from 007f0734 to 008f0737 has its CatchHandler @ 007f267c */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(pvVar6);
}


/* SYMBOL _ZN6Avalon7MapGrid5parseERKSs @ 007f0554 type=Label */

/* Avalon::MapGrid::parse(std::string const&) */

void Avalon::MapGrid::parse(string *param_1)

{
  uint uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  char cVar5;
  Image *this;
  void *pvVar6;
  int in_w4;
  int iVar7;
  MapGrid *this_00;
  float local_18;
  float local_14;
  byte local_10;
  byte local_f;
  byte local_e;
  char local_d;
  long local_8;
  
  iVar2 = DAT_0172500c;
                    /* try { // try from 007f0554 to 008f0557 has its CatchHandler @ 007f276c */
  iVar4 = DAT_01725008;
                    /* try { // try from 007f056c to 008f056f has its CatchHandler @ 007f2760 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 007f0584 to 008f0587 has its CatchHandler @ 007f2754 */
                    /* try { // try from 007f059c to 008f059f has its CatchHandler @ 007f2748 */
  this = operator_new(0x160);
  cocos2d::Image::Image(this);
                    /* try { // try from 007f05b4 to 008f05b7 has its CatchHandler @ 007f273c */
  cVar5 = cocos2d::Image::initWithImageFile(this,param_1);
  if (cVar5 == '\0') {
    pvVar6 = (void *)0x0;
  }
  else {
                    /* try { // try from 007f05cc to 008f05cf has its CatchHandler @ 007f2730 */
    iVar3 = DAT_0172500c * DAT_01725008;
                    /* try { // try from 007f05e4 to 008f05e7 has its CatchHandler @ 007f2724 */
    pvVar6 = operator_new__((long)(iVar3 + 1));
    memset(pvVar6,0x31,(long)iVar3);
                    /* try { // try from 007f05fc to 008f05ff has its CatchHandler @ 007f2718 */
    if (0 < DAT_01725008) {
      iVar7 = 0;
      if (iVar4 < iVar2) {
        iVar2 = iVar4;
      }
                    /* try { // try from 007f0614 to 008f0617 has its CatchHandler @ 007f270c */
      do {
                    /* try { // try from 007f062c to 008f062f has its CatchHandler @ 007f2700 */
        if (0 < DAT_0172500c) {
          this_00 = (MapGrid *)0x0;
          do {
            iVar4 = DAT_0172500c;
                    /* try { // try from 007f0644 to 008f0647 has its CatchHandler @ 007f26f4 */
            coordinateToPosition(this_00,iVar7,0x2c,0x16,in_w4);
                    /* try { // try from 007f065c to 008f065f has its CatchHandler @ 007f26e8 */
                    /* try { // try from 007f0674 to 008f0677 has its CatchHandler @ 007f26dc */
            local_14 = ((float)*(int *)(this + 0x3c) - local_14) - 11.0;
            local_18 = (float)(int)((double)(iVar2 * 0x2c) * 0.5) + local_18;
                    /* try { // try from 007f068c to 008f068f has its CatchHandler @ 007f26d0 */
            getPixelBytes(this,(int)local_18,(int)local_14,&local_10);
                    /* try { // try from 007f06a4 to 008f06a7 has its CatchHandler @ 007f26c4 */
                    /* try { // try from 007f06bc to 008f06bf has its CatchHandler @ 007f26b8 */
            if ((((0xfa < local_10) && (0xfa < local_f)) && (0xfa < local_e)) && (local_d != '\0'))
            {
              *(undefined1 *)((long)pvVar6 + (long)((int)this_00 + iVar7 * iVar4)) = 0x30;
            }
                    /* try { // try from 007f06d4 to 008f06d7 has its CatchHandler @ 007f26ac */
            uVar1 = (int)this_00 + 1;
            this_00 = (MapGrid *)(ulong)uVar1;
          } while ((int)uVar1 < DAT_0172500c);
        }
        iVar7 = iVar7 + 1;
                    /* try { // try from 007f06ec to 008f06ef has its CatchHandler @ 007f26a0 */
      } while (iVar7 < DAT_01725008);
    }
    *(undefined1 *)((long)pvVar6 + (long)iVar3) = 0;
  }
                    /* try { // try from 007f0704 to 008f0707 has its CatchHandler @ 007f2694 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 007f071c to 008f071f has its CatchHandler @ 007f2688 */
                    /* try { // try from 007f0734 to 008f0737 has its CatchHandler @ 007f267c */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(pvVar6);
}


/* SYMBOL Avalon::MapGrid::printPixel @ 007f0758 type=Function */

/* Avalon::MapGrid::printPixel(unsigned char*) */

void Avalon::MapGrid::printPixel(uchar *param_1)

{
  uchar *puVar1;
  long lVar2;
  
                    /* try { // try from 007f0764 to 008f0767 has its CatchHandler @ 007f2664 */
  lVar2 = 0;
  do {
    puVar1 = param_1 + lVar2;
                    /* try { // try from 007f077c to 008f077f has its CatchHandler @ 007f2658 */
    lVar2 = lVar2 + 1;
    printf(&DAT_0127e520,*puVar1);
  } while (lVar2 != 4);
                    /* try { // try from 007f0794 to 008f0797 has its CatchHandler @ 007f264c */
  return;
}


/* SYMBOL _ZN6Avalon7MapGrid10printPixelEPh @ 007f0758 type=Label */

/* Avalon::MapGrid::printPixel(unsigned char*) */

void Avalon::MapGrid::printPixel(uchar *param_1)

{
  uchar *puVar1;
  long lVar2;
  
                    /* try { // try from 007f0764 to 008f0767 has its CatchHandler @ 007f2664 */
  lVar2 = 0;
  do {
    puVar1 = param_1 + lVar2;
                    /* try { // try from 007f077c to 008f077f has its CatchHandler @ 007f2658 */
    lVar2 = lVar2 + 1;
    printf(&DAT_0127e520,*puVar1);
  } while (lVar2 != 4);
                    /* try { // try from 007f0794 to 008f0797 has its CatchHandler @ 007f264c */
  return;
}


/* SYMBOL Avalon::MapGrid::print @ 007f07a0 type=Function */

/* Avalon::MapGrid::print(char*) */

void Avalon::MapGrid::print(char *param_1)

{
  int iVar1;
  int iVar2;
  int iVar3;
  
                    /* try { // try from 007f07ac to 008f07af has its CatchHandler @ 007f2640 */
  iVar3 = 0;
                    /* try { // try from 007f07c4 to 008f07c7 has its CatchHandler @ 007f2634 */
  if (0 < DAT_01725008) {
    do {
      iVar2 = 0;
      if (0 < DAT_0172500c) {
        do {
                    /* try { // try from 007f07dc to 008f07df has its CatchHandler @ 007f2628 */
          iVar1 = iVar2 + iVar3 * DAT_0172500c;
          iVar2 = iVar2 + 1;
          putchar((long)param_1[iVar1]);
                    /* try { // try from 007f07f4 to 008f07f7 has its CatchHandler @ 007f261c */
        } while (iVar2 < DAT_0172500c);
      }
      iVar3 = iVar3 + 1;
      putchar(10);
                    /* try { // try from 007f080c to 008f080f has its CatchHandler @ 007f2610 */
    } while (iVar3 < DAT_01725008);
  }
  return;
}


/* SYMBOL _ZN6Avalon7MapGrid5printEPc @ 007f07a0 type=Label */

/* Avalon::MapGrid::print(char*) */

void Avalon::MapGrid::print(char *param_1)

{
  int iVar1;
  int iVar2;
  int iVar3;
  
                    /* try { // try from 007f07ac to 008f07af has its CatchHandler @ 007f2640 */
  iVar3 = 0;
                    /* try { // try from 007f07c4 to 008f07c7 has its CatchHandler @ 007f2634 */
  if (0 < DAT_01725008) {
    do {
      iVar2 = 0;
      if (0 < DAT_0172500c) {
        do {
                    /* try { // try from 007f07dc to 008f07df has its CatchHandler @ 007f2628 */
          iVar1 = iVar2 + iVar3 * DAT_0172500c;
          iVar2 = iVar2 + 1;
          putchar((long)param_1[iVar1]);
                    /* try { // try from 007f07f4 to 008f07f7 has its CatchHandler @ 007f261c */
        } while (iVar2 < DAT_0172500c);
      }
      iVar3 = iVar3 + 1;
      putchar(10);
                    /* try { // try from 007f080c to 008f080f has its CatchHandler @ 007f2610 */
    } while (iVar3 < DAT_01725008);
  }
  return;
}

