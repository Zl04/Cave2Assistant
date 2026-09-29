/* Targets: 6, callers: 2 */

/* === parse @ 007f0554 === */

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


/* === getPixelBytes @ 007f0300 === */

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

