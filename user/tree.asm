
user/_tree:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print_indent>:
#include "kernel/fs.h"
#include "user/user.h"

void print_indent(int depth)
{
    for (int i = 0; i < depth; i++)
   0:	02a05c63          	blez	a0,38 <print_indent+0x38>
{
   4:	7179                	addi	sp,sp,-48
   6:	f406                	sd	ra,40(sp)
   8:	f022                	sd	s0,32(sp)
   a:	ec26                	sd	s1,24(sp)
   c:	e84a                	sd	s2,16(sp)
   e:	e44e                	sd	s3,8(sp)
  10:	1800                	addi	s0,sp,48
  12:	892a                	mv	s2,a0
    for (int i = 0; i < depth; i++)
  14:	4481                	li	s1,0
        printf("  ");
  16:	00001997          	auipc	s3,0x1
  1a:	a9a98993          	addi	s3,s3,-1382 # ab0 <malloc+0x104>
  1e:	854e                	mv	a0,s3
  20:	0d9000ef          	jal	8f8 <printf>
    for (int i = 0; i < depth; i++)
  24:	2485                	addiw	s1,s1,1
  26:	fe991ce3          	bne	s2,s1,1e <print_indent+0x1e>
}
  2a:	70a2                	ld	ra,40(sp)
  2c:	7402                	ld	s0,32(sp)
  2e:	64e2                	ld	s1,24(sp)
  30:	6942                	ld	s2,16(sp)
  32:	69a2                	ld	s3,8(sp)
  34:	6145                	addi	sp,sp,48
  36:	8082                	ret
  38:	8082                	ret

000000000000003a <tree>:

void tree(char *path, int depth)
{
  3a:	d8010113          	addi	sp,sp,-640
  3e:	26113c23          	sd	ra,632(sp)
  42:	26813823          	sd	s0,624(sp)
  46:	27213023          	sd	s2,608(sp)
  4a:	25313c23          	sd	s3,600(sp)
  4e:	0500                	addi	s0,sp,640
  50:	892a                	mv	s2,a0
  52:	89ae                	mv	s3,a1
    struct stat st;
    struct dirent de;
    char buf[512];
    char name[DIRSIZ + 1];

    if ((fd = open(path, 0)) < 0)
  54:	4581                	li	a1,0
  56:	4ca000ef          	jal	520 <open>
  5a:	10054163          	bltz	a0,15c <tree+0x122>
  5e:	26913423          	sd	s1,616(sp)
  62:	84aa                	mv	s1,a0
    {
        fprintf(2, "tree: cannot open %s\n", path);
        exit(1);
    }

    if (fstat(fd, &st) < 0)
  64:	fa840593          	addi	a1,s0,-88
  68:	4d0000ef          	jal	538 <fstat>
  6c:	10054b63          	bltz	a0,182 <tree+0x148>
        fprintf(2, "tree: cannot stat %s\n", path);
        close(fd);
        exit(1);
    }

    if (st.type != T_DIR)
  70:	fb041703          	lh	a4,-80(s0)
  74:	4785                	li	a5,1
  76:	12f71a63          	bne	a4,a5,1aa <tree+0x170>
  7a:	25513423          	sd	s5,584(sp)
  7e:	25613023          	sd	s6,576(sp)
            continue;

        memmove(name, de.name, DIRSIZ);
        name[DIRSIZ] = 0;

        if (strcmp(name, ".") == 0 || strcmp(name, "..") == 0)
  82:	00001a97          	auipc	s5,0x1
  86:	a66a8a93          	addi	s5,s5,-1434 # ae8 <malloc+0x13c>
  8a:	00001b17          	auipc	s6,0x1
  8e:	a66b0b13          	addi	s6,s6,-1434 # af0 <malloc+0x144>
    while (read(fd, &de, sizeof(de)) == sizeof(de))
  92:	4641                	li	a2,16
  94:	f9840593          	addi	a1,s0,-104
  98:	8526                	mv	a0,s1
  9a:	45e000ef          	jal	4f8 <read>
  9e:	47c1                	li	a5,16
  a0:	14f51e63          	bne	a0,a5,1fc <tree+0x1c2>
        if (de.inum == 0)
  a4:	f9845783          	lhu	a5,-104(s0)
  a8:	d7ed                	beqz	a5,92 <tree+0x58>
        memmove(name, de.name, DIRSIZ);
  aa:	4639                	li	a2,14
  ac:	f9a40593          	addi	a1,s0,-102
  b0:	d8840513          	addi	a0,s0,-632
  b4:	37e000ef          	jal	432 <memmove>
        name[DIRSIZ] = 0;
  b8:	d8040b23          	sb	zero,-618(s0)
        if (strcmp(name, ".") == 0 || strcmp(name, "..") == 0)
  bc:	85d6                	mv	a1,s5
  be:	d8840513          	addi	a0,s0,-632
  c2:	1e2000ef          	jal	2a4 <strcmp>
  c6:	d571                	beqz	a0,92 <tree+0x58>
  c8:	85da                	mv	a1,s6
  ca:	d8840513          	addi	a0,s0,-632
  ce:	1d6000ef          	jal	2a4 <strcmp>
  d2:	d161                	beqz	a0,92 <tree+0x58>
  d4:	25413823          	sd	s4,592(sp)
            continue;

        if (strlen(path) + 1 + strlen(name) + 1 > sizeof(buf))
  d8:	854a                	mv	a0,s2
  da:	1f6000ef          	jal	2d0 <strlen>
  de:	00050a1b          	sext.w	s4,a0
  e2:	d8840513          	addi	a0,s0,-632
  e6:	1ea000ef          	jal	2d0 <strlen>
  ea:	00aa0a3b          	addw	s4,s4,a0
  ee:	2a09                	addiw	s4,s4,2
  f0:	20000793          	li	a5,512
  f4:	0b47ef63          	bltu	a5,s4,1b2 <tree+0x178>
        {
            printf("tree: path too long\n");
            continue;
        }

        strcpy(buf, path);
  f8:	85ca                	mv	a1,s2
  fa:	d9840513          	addi	a0,s0,-616
  fe:	18a000ef          	jal	288 <strcpy>
        char *p = buf + strlen(buf);
 102:	d9840513          	addi	a0,s0,-616
 106:	1ca000ef          	jal	2d0 <strlen>
 10a:	1502                	slli	a0,a0,0x20
 10c:	9101                	srli	a0,a0,0x20
 10e:	d9840793          	addi	a5,s0,-616
 112:	953e                	add	a0,a0,a5
        *p++ = '/';
 114:	02f00793          	li	a5,47
 118:	00f50023          	sb	a5,0(a0)
        strcpy(p, name);
 11c:	d8840593          	addi	a1,s0,-632
 120:	0505                	addi	a0,a0,1
 122:	166000ef          	jal	288 <strcpy>

        if (stat(buf, &st) < 0)
 126:	fa840593          	addi	a1,s0,-88
 12a:	d9840513          	addi	a0,s0,-616
 12e:	282000ef          	jal	3b0 <stat>
 132:	08054963          	bltz	a0,1c4 <tree+0x18a>
        {
            printf("tree: cannot stat %s\n", buf);
            continue;
        }

        print_indent(depth);
 136:	854e                	mv	a0,s3
 138:	ec9ff0ef          	jal	0 <print_indent>

        if (st.type == T_DIR)
 13c:	fb041703          	lh	a4,-80(s0)
 140:	4785                	li	a5,1
 142:	08f70c63          	beq	a4,a5,1da <tree+0x1a0>
            printf("%s/\n", name);
            tree(buf, depth + 1);
        }
        else
        {
            printf("%s\n", name);
 146:	d8840593          	addi	a1,s0,-632
 14a:	00001517          	auipc	a0,0x1
 14e:	9ce50513          	addi	a0,a0,-1586 # b18 <malloc+0x16c>
 152:	7a6000ef          	jal	8f8 <printf>
 156:	25013a03          	ld	s4,592(sp)
 15a:	bf25                	j	92 <tree+0x58>
 15c:	26913423          	sd	s1,616(sp)
 160:	25413823          	sd	s4,592(sp)
 164:	25513423          	sd	s5,584(sp)
 168:	25613023          	sd	s6,576(sp)
        fprintf(2, "tree: cannot open %s\n", path);
 16c:	864a                	mv	a2,s2
 16e:	00001597          	auipc	a1,0x1
 172:	94a58593          	addi	a1,a1,-1718 # ab8 <malloc+0x10c>
 176:	4509                	li	a0,2
 178:	756000ef          	jal	8ce <fprintf>
        exit(1);
 17c:	4505                	li	a0,1
 17e:	362000ef          	jal	4e0 <exit>
 182:	25413823          	sd	s4,592(sp)
 186:	25513423          	sd	s5,584(sp)
 18a:	25613023          	sd	s6,576(sp)
        fprintf(2, "tree: cannot stat %s\n", path);
 18e:	864a                	mv	a2,s2
 190:	00001597          	auipc	a1,0x1
 194:	94058593          	addi	a1,a1,-1728 # ad0 <malloc+0x124>
 198:	4509                	li	a0,2
 19a:	734000ef          	jal	8ce <fprintf>
        close(fd);
 19e:	8526                	mv	a0,s1
 1a0:	368000ef          	jal	508 <close>
        exit(1);
 1a4:	4505                	li	a0,1
 1a6:	33a000ef          	jal	4e0 <exit>
        close(fd);
 1aa:	8526                	mv	a0,s1
 1ac:	35c000ef          	jal	508 <close>
        return;
 1b0:	a8a9                	j	20a <tree+0x1d0>
            printf("tree: path too long\n");
 1b2:	00001517          	auipc	a0,0x1
 1b6:	94650513          	addi	a0,a0,-1722 # af8 <malloc+0x14c>
 1ba:	73e000ef          	jal	8f8 <printf>
            continue;
 1be:	25013a03          	ld	s4,592(sp)
 1c2:	bdc1                	j	92 <tree+0x58>
            printf("tree: cannot stat %s\n", buf);
 1c4:	d9840593          	addi	a1,s0,-616
 1c8:	00001517          	auipc	a0,0x1
 1cc:	90850513          	addi	a0,a0,-1784 # ad0 <malloc+0x124>
 1d0:	728000ef          	jal	8f8 <printf>
            continue;
 1d4:	25013a03          	ld	s4,592(sp)
 1d8:	bd6d                	j	92 <tree+0x58>
            printf("%s/\n", name);
 1da:	d8840593          	addi	a1,s0,-632
 1de:	00001517          	auipc	a0,0x1
 1e2:	93250513          	addi	a0,a0,-1742 # b10 <malloc+0x164>
 1e6:	712000ef          	jal	8f8 <printf>
            tree(buf, depth + 1);
 1ea:	0019859b          	addiw	a1,s3,1
 1ee:	d9840513          	addi	a0,s0,-616
 1f2:	e49ff0ef          	jal	3a <tree>
 1f6:	25013a03          	ld	s4,592(sp)
 1fa:	bd61                	j	92 <tree+0x58>
        }
    }

    close(fd);
 1fc:	8526                	mv	a0,s1
 1fe:	30a000ef          	jal	508 <close>
 202:	24813a83          	ld	s5,584(sp)
 206:	24013b03          	ld	s6,576(sp)
 20a:	26813483          	ld	s1,616(sp)
}
 20e:	27813083          	ld	ra,632(sp)
 212:	27013403          	ld	s0,624(sp)
 216:	26013903          	ld	s2,608(sp)
 21a:	25813983          	ld	s3,600(sp)
 21e:	28010113          	addi	sp,sp,640
 222:	8082                	ret

0000000000000224 <main>:

int main(int argc, char *argv[])
{
 224:	1101                	addi	sp,sp,-32
 226:	ec06                	sd	ra,24(sp)
 228:	e822                	sd	s0,16(sp)
 22a:	1000                	addi	s0,sp,32
    char *path;

    if (argc > 2)
 22c:	4789                	li	a5,2
 22e:	02a7c963          	blt	a5,a0,260 <main+0x3c>
 232:	e426                	sd	s1,8(sp)
    {
        fprintf(2, "usage: tree [directory]\n");
        exit(1);
    }

    if (argc == 1)
 234:	4785                	li	a5,1
        path = ".";
 236:	00001497          	auipc	s1,0x1
 23a:	8b248493          	addi	s1,s1,-1870 # ae8 <malloc+0x13c>
    if (argc == 1)
 23e:	00f50363          	beq	a0,a5,244 <main+0x20>
    else
        path = argv[1];
 242:	6584                	ld	s1,8(a1)

    printf("%s/\n", path);
 244:	85a6                	mv	a1,s1
 246:	00001517          	auipc	a0,0x1
 24a:	8ca50513          	addi	a0,a0,-1846 # b10 <malloc+0x164>
 24e:	6aa000ef          	jal	8f8 <printf>

    tree(path, 1);
 252:	4585                	li	a1,1
 254:	8526                	mv	a0,s1
 256:	de5ff0ef          	jal	3a <tree>

    exit(0);
 25a:	4501                	li	a0,0
 25c:	284000ef          	jal	4e0 <exit>
 260:	e426                	sd	s1,8(sp)
        fprintf(2, "usage: tree [directory]\n");
 262:	00001597          	auipc	a1,0x1
 266:	8be58593          	addi	a1,a1,-1858 # b20 <malloc+0x174>
 26a:	4509                	li	a0,2
 26c:	662000ef          	jal	8ce <fprintf>
        exit(1);
 270:	4505                	li	a0,1
 272:	26e000ef          	jal	4e0 <exit>

0000000000000276 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 276:	1141                	addi	sp,sp,-16
 278:	e406                	sd	ra,8(sp)
 27a:	e022                	sd	s0,0(sp)
 27c:	0800                	addi	s0,sp,16
  extern int main();
  main();
 27e:	fa7ff0ef          	jal	224 <main>
  exit(0);
 282:	4501                	li	a0,0
 284:	25c000ef          	jal	4e0 <exit>

0000000000000288 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 28e:	87aa                	mv	a5,a0
 290:	0585                	addi	a1,a1,1
 292:	0785                	addi	a5,a5,1
 294:	fff5c703          	lbu	a4,-1(a1)
 298:	fee78fa3          	sb	a4,-1(a5)
 29c:	fb75                	bnez	a4,290 <strcpy+0x8>
    ;
  return os;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret

00000000000002a4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e422                	sd	s0,8(sp)
 2a8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2aa:	00054783          	lbu	a5,0(a0)
 2ae:	cb91                	beqz	a5,2c2 <strcmp+0x1e>
 2b0:	0005c703          	lbu	a4,0(a1)
 2b4:	00f71763          	bne	a4,a5,2c2 <strcmp+0x1e>
    p++, q++;
 2b8:	0505                	addi	a0,a0,1
 2ba:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2bc:	00054783          	lbu	a5,0(a0)
 2c0:	fbe5                	bnez	a5,2b0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2c2:	0005c503          	lbu	a0,0(a1)
}
 2c6:	40a7853b          	subw	a0,a5,a0
 2ca:	6422                	ld	s0,8(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <strlen>:

uint
strlen(const char *s)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2d6:	00054783          	lbu	a5,0(a0)
 2da:	cf91                	beqz	a5,2f6 <strlen+0x26>
 2dc:	0505                	addi	a0,a0,1
 2de:	87aa                	mv	a5,a0
 2e0:	86be                	mv	a3,a5
 2e2:	0785                	addi	a5,a5,1
 2e4:	fff7c703          	lbu	a4,-1(a5)
 2e8:	ff65                	bnez	a4,2e0 <strlen+0x10>
 2ea:	40a6853b          	subw	a0,a3,a0
 2ee:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
  for(n = 0; s[n]; n++)
 2f6:	4501                	li	a0,0
 2f8:	bfe5                	j	2f0 <strlen+0x20>

00000000000002fa <memset>:

void*
memset(void *dst, int c, uint n)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 300:	ca19                	beqz	a2,316 <memset+0x1c>
 302:	87aa                	mv	a5,a0
 304:	1602                	slli	a2,a2,0x20
 306:	9201                	srli	a2,a2,0x20
 308:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 30c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 310:	0785                	addi	a5,a5,1
 312:	fee79de3          	bne	a5,a4,30c <memset+0x12>
  }
  return dst;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret

000000000000031c <strchr>:

char*
strchr(const char *s, char c)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	addi	s0,sp,16
  for(; *s; s++)
 322:	00054783          	lbu	a5,0(a0)
 326:	cb99                	beqz	a5,33c <strchr+0x20>
    if(*s == c)
 328:	00f58763          	beq	a1,a5,336 <strchr+0x1a>
  for(; *s; s++)
 32c:	0505                	addi	a0,a0,1
 32e:	00054783          	lbu	a5,0(a0)
 332:	fbfd                	bnez	a5,328 <strchr+0xc>
      return (char*)s;
  return 0;
 334:	4501                	li	a0,0
}
 336:	6422                	ld	s0,8(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret
  return 0;
 33c:	4501                	li	a0,0
 33e:	bfe5                	j	336 <strchr+0x1a>

0000000000000340 <gets>:

char*
gets(char *buf, int max)
{
 340:	711d                	addi	sp,sp,-96
 342:	ec86                	sd	ra,88(sp)
 344:	e8a2                	sd	s0,80(sp)
 346:	e4a6                	sd	s1,72(sp)
 348:	e0ca                	sd	s2,64(sp)
 34a:	fc4e                	sd	s3,56(sp)
 34c:	f852                	sd	s4,48(sp)
 34e:	f456                	sd	s5,40(sp)
 350:	f05a                	sd	s6,32(sp)
 352:	ec5e                	sd	s7,24(sp)
 354:	1080                	addi	s0,sp,96
 356:	8baa                	mv	s7,a0
 358:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 35a:	892a                	mv	s2,a0
 35c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 35e:	4aa9                	li	s5,10
 360:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 362:	89a6                	mv	s3,s1
 364:	2485                	addiw	s1,s1,1
 366:	0344d663          	bge	s1,s4,392 <gets+0x52>
    cc = read(0, &c, 1);
 36a:	4605                	li	a2,1
 36c:	faf40593          	addi	a1,s0,-81
 370:	4501                	li	a0,0
 372:	186000ef          	jal	4f8 <read>
    if(cc < 1)
 376:	00a05e63          	blez	a0,392 <gets+0x52>
    buf[i++] = c;
 37a:	faf44783          	lbu	a5,-81(s0)
 37e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 382:	01578763          	beq	a5,s5,390 <gets+0x50>
 386:	0905                	addi	s2,s2,1
 388:	fd679de3          	bne	a5,s6,362 <gets+0x22>
    buf[i++] = c;
 38c:	89a6                	mv	s3,s1
 38e:	a011                	j	392 <gets+0x52>
 390:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 392:	99de                	add	s3,s3,s7
 394:	00098023          	sb	zero,0(s3)
  return buf;
}
 398:	855e                	mv	a0,s7
 39a:	60e6                	ld	ra,88(sp)
 39c:	6446                	ld	s0,80(sp)
 39e:	64a6                	ld	s1,72(sp)
 3a0:	6906                	ld	s2,64(sp)
 3a2:	79e2                	ld	s3,56(sp)
 3a4:	7a42                	ld	s4,48(sp)
 3a6:	7aa2                	ld	s5,40(sp)
 3a8:	7b02                	ld	s6,32(sp)
 3aa:	6be2                	ld	s7,24(sp)
 3ac:	6125                	addi	sp,sp,96
 3ae:	8082                	ret

00000000000003b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b0:	1101                	addi	sp,sp,-32
 3b2:	ec06                	sd	ra,24(sp)
 3b4:	e822                	sd	s0,16(sp)
 3b6:	e04a                	sd	s2,0(sp)
 3b8:	1000                	addi	s0,sp,32
 3ba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3bc:	4581                	li	a1,0
 3be:	162000ef          	jal	520 <open>
  if(fd < 0)
 3c2:	02054263          	bltz	a0,3e6 <stat+0x36>
 3c6:	e426                	sd	s1,8(sp)
 3c8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ca:	85ca                	mv	a1,s2
 3cc:	16c000ef          	jal	538 <fstat>
 3d0:	892a                	mv	s2,a0
  close(fd);
 3d2:	8526                	mv	a0,s1
 3d4:	134000ef          	jal	508 <close>
  return r;
 3d8:	64a2                	ld	s1,8(sp)
}
 3da:	854a                	mv	a0,s2
 3dc:	60e2                	ld	ra,24(sp)
 3de:	6442                	ld	s0,16(sp)
 3e0:	6902                	ld	s2,0(sp)
 3e2:	6105                	addi	sp,sp,32
 3e4:	8082                	ret
    return -1;
 3e6:	597d                	li	s2,-1
 3e8:	bfcd                	j	3da <stat+0x2a>

00000000000003ea <atoi>:

int
atoi(const char *s)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e422                	sd	s0,8(sp)
 3ee:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f0:	00054683          	lbu	a3,0(a0)
 3f4:	fd06879b          	addiw	a5,a3,-48
 3f8:	0ff7f793          	zext.b	a5,a5
 3fc:	4625                	li	a2,9
 3fe:	02f66863          	bltu	a2,a5,42e <atoi+0x44>
 402:	872a                	mv	a4,a0
  n = 0;
 404:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 406:	0705                	addi	a4,a4,1
 408:	0025179b          	slliw	a5,a0,0x2
 40c:	9fa9                	addw	a5,a5,a0
 40e:	0017979b          	slliw	a5,a5,0x1
 412:	9fb5                	addw	a5,a5,a3
 414:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 418:	00074683          	lbu	a3,0(a4)
 41c:	fd06879b          	addiw	a5,a3,-48
 420:	0ff7f793          	zext.b	a5,a5
 424:	fef671e3          	bgeu	a2,a5,406 <atoi+0x1c>
  return n;
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
  n = 0;
 42e:	4501                	li	a0,0
 430:	bfe5                	j	428 <atoi+0x3e>

0000000000000432 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 438:	02b57463          	bgeu	a0,a1,460 <memmove+0x2e>
    while(n-- > 0)
 43c:	00c05f63          	blez	a2,45a <memmove+0x28>
 440:	1602                	slli	a2,a2,0x20
 442:	9201                	srli	a2,a2,0x20
 444:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 448:	872a                	mv	a4,a0
      *dst++ = *src++;
 44a:	0585                	addi	a1,a1,1
 44c:	0705                	addi	a4,a4,1
 44e:	fff5c683          	lbu	a3,-1(a1)
 452:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 456:	fef71ae3          	bne	a4,a5,44a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 45a:	6422                	ld	s0,8(sp)
 45c:	0141                	addi	sp,sp,16
 45e:	8082                	ret
    dst += n;
 460:	00c50733          	add	a4,a0,a2
    src += n;
 464:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 466:	fec05ae3          	blez	a2,45a <memmove+0x28>
 46a:	fff6079b          	addiw	a5,a2,-1
 46e:	1782                	slli	a5,a5,0x20
 470:	9381                	srli	a5,a5,0x20
 472:	fff7c793          	not	a5,a5
 476:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 478:	15fd                	addi	a1,a1,-1
 47a:	177d                	addi	a4,a4,-1
 47c:	0005c683          	lbu	a3,0(a1)
 480:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 484:	fee79ae3          	bne	a5,a4,478 <memmove+0x46>
 488:	bfc9                	j	45a <memmove+0x28>

000000000000048a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 490:	ca05                	beqz	a2,4c0 <memcmp+0x36>
 492:	fff6069b          	addiw	a3,a2,-1
 496:	1682                	slli	a3,a3,0x20
 498:	9281                	srli	a3,a3,0x20
 49a:	0685                	addi	a3,a3,1
 49c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	0005c703          	lbu	a4,0(a1)
 4a6:	00e79863          	bne	a5,a4,4b6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4aa:	0505                	addi	a0,a0,1
    p2++;
 4ac:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ae:	fed518e3          	bne	a0,a3,49e <memcmp+0x14>
  }
  return 0;
 4b2:	4501                	li	a0,0
 4b4:	a019                	j	4ba <memcmp+0x30>
      return *p1 - *p2;
 4b6:	40e7853b          	subw	a0,a5,a4
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
  return 0;
 4c0:	4501                	li	a0,0
 4c2:	bfe5                	j	4ba <memcmp+0x30>

00000000000004c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e406                	sd	ra,8(sp)
 4c8:	e022                	sd	s0,0(sp)
 4ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4cc:	f67ff0ef          	jal	432 <memmove>
}
 4d0:	60a2                	ld	ra,8(sp)
 4d2:	6402                	ld	s0,0(sp)
 4d4:	0141                	addi	sp,sp,16
 4d6:	8082                	ret

00000000000004d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4d8:	4885                	li	a7,1
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e0:	4889                	li	a7,2
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4e8:	488d                	li	a7,3
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f0:	4891                	li	a7,4
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <read>:
.global read
read:
 li a7, SYS_read
 4f8:	4895                	li	a7,5
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <write>:
.global write
write:
 li a7, SYS_write
 500:	48c1                	li	a7,16
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <close>:
.global close
close:
 li a7, SYS_close
 508:	48d5                	li	a7,21
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <kill>:
.global kill
kill:
 li a7, SYS_kill
 510:	4899                	li	a7,6
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <exec>:
.global exec
exec:
 li a7, SYS_exec
 518:	489d                	li	a7,7
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <open>:
.global open
open:
 li a7, SYS_open
 520:	48bd                	li	a7,15
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 528:	48c5                	li	a7,17
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 530:	48c9                	li	a7,18
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 538:	48a1                	li	a7,8
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <link>:
.global link
link:
 li a7, SYS_link
 540:	48cd                	li	a7,19
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 548:	48d1                	li	a7,20
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 550:	48a5                	li	a7,9
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <dup>:
.global dup
dup:
 li a7, SYS_dup
 558:	48a9                	li	a7,10
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 560:	48ad                	li	a7,11
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 568:	48b1                	li	a7,12
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 570:	48b5                	li	a7,13
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 578:	48b9                	li	a7,14
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 580:	1101                	addi	sp,sp,-32
 582:	ec06                	sd	ra,24(sp)
 584:	e822                	sd	s0,16(sp)
 586:	1000                	addi	s0,sp,32
 588:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 58c:	4605                	li	a2,1
 58e:	fef40593          	addi	a1,s0,-17
 592:	f6fff0ef          	jal	500 <write>
}
 596:	60e2                	ld	ra,24(sp)
 598:	6442                	ld	s0,16(sp)
 59a:	6105                	addi	sp,sp,32
 59c:	8082                	ret

000000000000059e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 59e:	7139                	addi	sp,sp,-64
 5a0:	fc06                	sd	ra,56(sp)
 5a2:	f822                	sd	s0,48(sp)
 5a4:	f426                	sd	s1,40(sp)
 5a6:	0080                	addi	s0,sp,64
 5a8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5aa:	c299                	beqz	a3,5b0 <printint+0x12>
 5ac:	0805c963          	bltz	a1,63e <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b0:	2581                	sext.w	a1,a1
  neg = 0;
 5b2:	4881                	li	a7,0
 5b4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5b8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ba:	2601                	sext.w	a2,a2
 5bc:	00000517          	auipc	a0,0x0
 5c0:	58c50513          	addi	a0,a0,1420 # b48 <digits>
 5c4:	883a                	mv	a6,a4
 5c6:	2705                	addiw	a4,a4,1
 5c8:	02c5f7bb          	remuw	a5,a1,a2
 5cc:	1782                	slli	a5,a5,0x20
 5ce:	9381                	srli	a5,a5,0x20
 5d0:	97aa                	add	a5,a5,a0
 5d2:	0007c783          	lbu	a5,0(a5)
 5d6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5da:	0005879b          	sext.w	a5,a1
 5de:	02c5d5bb          	divuw	a1,a1,a2
 5e2:	0685                	addi	a3,a3,1
 5e4:	fec7f0e3          	bgeu	a5,a2,5c4 <printint+0x26>
  if(neg)
 5e8:	00088c63          	beqz	a7,600 <printint+0x62>
    buf[i++] = '-';
 5ec:	fd070793          	addi	a5,a4,-48
 5f0:	00878733          	add	a4,a5,s0
 5f4:	02d00793          	li	a5,45
 5f8:	fef70823          	sb	a5,-16(a4)
 5fc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 600:	02e05a63          	blez	a4,634 <printint+0x96>
 604:	f04a                	sd	s2,32(sp)
 606:	ec4e                	sd	s3,24(sp)
 608:	fc040793          	addi	a5,s0,-64
 60c:	00e78933          	add	s2,a5,a4
 610:	fff78993          	addi	s3,a5,-1
 614:	99ba                	add	s3,s3,a4
 616:	377d                	addiw	a4,a4,-1
 618:	1702                	slli	a4,a4,0x20
 61a:	9301                	srli	a4,a4,0x20
 61c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 620:	fff94583          	lbu	a1,-1(s2)
 624:	8526                	mv	a0,s1
 626:	f5bff0ef          	jal	580 <putc>
  while(--i >= 0)
 62a:	197d                	addi	s2,s2,-1
 62c:	ff391ae3          	bne	s2,s3,620 <printint+0x82>
 630:	7902                	ld	s2,32(sp)
 632:	69e2                	ld	s3,24(sp)
}
 634:	70e2                	ld	ra,56(sp)
 636:	7442                	ld	s0,48(sp)
 638:	74a2                	ld	s1,40(sp)
 63a:	6121                	addi	sp,sp,64
 63c:	8082                	ret
    x = -xx;
 63e:	40b005bb          	negw	a1,a1
    neg = 1;
 642:	4885                	li	a7,1
    x = -xx;
 644:	bf85                	j	5b4 <printint+0x16>

0000000000000646 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 646:	711d                	addi	sp,sp,-96
 648:	ec86                	sd	ra,88(sp)
 64a:	e8a2                	sd	s0,80(sp)
 64c:	e0ca                	sd	s2,64(sp)
 64e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 650:	0005c903          	lbu	s2,0(a1)
 654:	26090863          	beqz	s2,8c4 <vprintf+0x27e>
 658:	e4a6                	sd	s1,72(sp)
 65a:	fc4e                	sd	s3,56(sp)
 65c:	f852                	sd	s4,48(sp)
 65e:	f456                	sd	s5,40(sp)
 660:	f05a                	sd	s6,32(sp)
 662:	ec5e                	sd	s7,24(sp)
 664:	e862                	sd	s8,16(sp)
 666:	e466                	sd	s9,8(sp)
 668:	8b2a                	mv	s6,a0
 66a:	8a2e                	mv	s4,a1
 66c:	8bb2                	mv	s7,a2
  state = 0;
 66e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 670:	4481                	li	s1,0
 672:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 674:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 678:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 67c:	06c00c93          	li	s9,108
 680:	a005                	j	6a0 <vprintf+0x5a>
        putc(fd, c0);
 682:	85ca                	mv	a1,s2
 684:	855a                	mv	a0,s6
 686:	efbff0ef          	jal	580 <putc>
 68a:	a019                	j	690 <vprintf+0x4a>
    } else if(state == '%'){
 68c:	03598263          	beq	s3,s5,6b0 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 690:	2485                	addiw	s1,s1,1
 692:	8726                	mv	a4,s1
 694:	009a07b3          	add	a5,s4,s1
 698:	0007c903          	lbu	s2,0(a5)
 69c:	20090c63          	beqz	s2,8b4 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 6a0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6a4:	fe0994e3          	bnez	s3,68c <vprintf+0x46>
      if(c0 == '%'){
 6a8:	fd579de3          	bne	a5,s5,682 <vprintf+0x3c>
        state = '%';
 6ac:	89be                	mv	s3,a5
 6ae:	b7cd                	j	690 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6b0:	00ea06b3          	add	a3,s4,a4
 6b4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6b8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6ba:	c681                	beqz	a3,6c2 <vprintf+0x7c>
 6bc:	9752                	add	a4,a4,s4
 6be:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6c2:	03878f63          	beq	a5,s8,700 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 6c6:	05978963          	beq	a5,s9,718 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6ca:	07500713          	li	a4,117
 6ce:	0ee78363          	beq	a5,a4,7b4 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6d2:	07800713          	li	a4,120
 6d6:	12e78563          	beq	a5,a4,800 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6da:	07000713          	li	a4,112
 6de:	14e78a63          	beq	a5,a4,832 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 6e2:	07300713          	li	a4,115
 6e6:	18e78a63          	beq	a5,a4,87a <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6ea:	02500713          	li	a4,37
 6ee:	04e79563          	bne	a5,a4,738 <vprintf+0xf2>
        putc(fd, '%');
 6f2:	02500593          	li	a1,37
 6f6:	855a                	mv	a0,s6
 6f8:	e89ff0ef          	jal	580 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	bf49                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 700:	008b8913          	addi	s2,s7,8
 704:	4685                	li	a3,1
 706:	4629                	li	a2,10
 708:	000ba583          	lw	a1,0(s7)
 70c:	855a                	mv	a0,s6
 70e:	e91ff0ef          	jal	59e <printint>
 712:	8bca                	mv	s7,s2
      state = 0;
 714:	4981                	li	s3,0
 716:	bfad                	j	690 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 718:	06400793          	li	a5,100
 71c:	02f68963          	beq	a3,a5,74e <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 720:	06c00793          	li	a5,108
 724:	04f68263          	beq	a3,a5,768 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 728:	07500793          	li	a5,117
 72c:	0af68063          	beq	a3,a5,7cc <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 730:	07800793          	li	a5,120
 734:	0ef68263          	beq	a3,a5,818 <vprintf+0x1d2>
        putc(fd, '%');
 738:	02500593          	li	a1,37
 73c:	855a                	mv	a0,s6
 73e:	e43ff0ef          	jal	580 <putc>
        putc(fd, c0);
 742:	85ca                	mv	a1,s2
 744:	855a                	mv	a0,s6
 746:	e3bff0ef          	jal	580 <putc>
      state = 0;
 74a:	4981                	li	s3,0
 74c:	b791                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 74e:	008b8913          	addi	s2,s7,8
 752:	4685                	li	a3,1
 754:	4629                	li	a2,10
 756:	000ba583          	lw	a1,0(s7)
 75a:	855a                	mv	a0,s6
 75c:	e43ff0ef          	jal	59e <printint>
        i += 1;
 760:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 762:	8bca                	mv	s7,s2
      state = 0;
 764:	4981                	li	s3,0
        i += 1;
 766:	b72d                	j	690 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 768:	06400793          	li	a5,100
 76c:	02f60763          	beq	a2,a5,79a <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 770:	07500793          	li	a5,117
 774:	06f60963          	beq	a2,a5,7e6 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 778:	07800793          	li	a5,120
 77c:	faf61ee3          	bne	a2,a5,738 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 780:	008b8913          	addi	s2,s7,8
 784:	4681                	li	a3,0
 786:	4641                	li	a2,16
 788:	000ba583          	lw	a1,0(s7)
 78c:	855a                	mv	a0,s6
 78e:	e11ff0ef          	jal	59e <printint>
        i += 2;
 792:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 794:	8bca                	mv	s7,s2
      state = 0;
 796:	4981                	li	s3,0
        i += 2;
 798:	bde5                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 79a:	008b8913          	addi	s2,s7,8
 79e:	4685                	li	a3,1
 7a0:	4629                	li	a2,10
 7a2:	000ba583          	lw	a1,0(s7)
 7a6:	855a                	mv	a0,s6
 7a8:	df7ff0ef          	jal	59e <printint>
        i += 2;
 7ac:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ae:	8bca                	mv	s7,s2
      state = 0;
 7b0:	4981                	li	s3,0
        i += 2;
 7b2:	bdf9                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 7b4:	008b8913          	addi	s2,s7,8
 7b8:	4681                	li	a3,0
 7ba:	4629                	li	a2,10
 7bc:	000ba583          	lw	a1,0(s7)
 7c0:	855a                	mv	a0,s6
 7c2:	dddff0ef          	jal	59e <printint>
 7c6:	8bca                	mv	s7,s2
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	b5d9                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7cc:	008b8913          	addi	s2,s7,8
 7d0:	4681                	li	a3,0
 7d2:	4629                	li	a2,10
 7d4:	000ba583          	lw	a1,0(s7)
 7d8:	855a                	mv	a0,s6
 7da:	dc5ff0ef          	jal	59e <printint>
        i += 1;
 7de:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e0:	8bca                	mv	s7,s2
      state = 0;
 7e2:	4981                	li	s3,0
        i += 1;
 7e4:	b575                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e6:	008b8913          	addi	s2,s7,8
 7ea:	4681                	li	a3,0
 7ec:	4629                	li	a2,10
 7ee:	000ba583          	lw	a1,0(s7)
 7f2:	855a                	mv	a0,s6
 7f4:	dabff0ef          	jal	59e <printint>
        i += 2;
 7f8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fa:	8bca                	mv	s7,s2
      state = 0;
 7fc:	4981                	li	s3,0
        i += 2;
 7fe:	bd49                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 800:	008b8913          	addi	s2,s7,8
 804:	4681                	li	a3,0
 806:	4641                	li	a2,16
 808:	000ba583          	lw	a1,0(s7)
 80c:	855a                	mv	a0,s6
 80e:	d91ff0ef          	jal	59e <printint>
 812:	8bca                	mv	s7,s2
      state = 0;
 814:	4981                	li	s3,0
 816:	bdad                	j	690 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 818:	008b8913          	addi	s2,s7,8
 81c:	4681                	li	a3,0
 81e:	4641                	li	a2,16
 820:	000ba583          	lw	a1,0(s7)
 824:	855a                	mv	a0,s6
 826:	d79ff0ef          	jal	59e <printint>
        i += 1;
 82a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 82c:	8bca                	mv	s7,s2
      state = 0;
 82e:	4981                	li	s3,0
        i += 1;
 830:	b585                	j	690 <vprintf+0x4a>
 832:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 834:	008b8d13          	addi	s10,s7,8
 838:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 83c:	03000593          	li	a1,48
 840:	855a                	mv	a0,s6
 842:	d3fff0ef          	jal	580 <putc>
  putc(fd, 'x');
 846:	07800593          	li	a1,120
 84a:	855a                	mv	a0,s6
 84c:	d35ff0ef          	jal	580 <putc>
 850:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 852:	00000b97          	auipc	s7,0x0
 856:	2f6b8b93          	addi	s7,s7,758 # b48 <digits>
 85a:	03c9d793          	srli	a5,s3,0x3c
 85e:	97de                	add	a5,a5,s7
 860:	0007c583          	lbu	a1,0(a5)
 864:	855a                	mv	a0,s6
 866:	d1bff0ef          	jal	580 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 86a:	0992                	slli	s3,s3,0x4
 86c:	397d                	addiw	s2,s2,-1
 86e:	fe0916e3          	bnez	s2,85a <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 872:	8bea                	mv	s7,s10
      state = 0;
 874:	4981                	li	s3,0
 876:	6d02                	ld	s10,0(sp)
 878:	bd21                	j	690 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 87a:	008b8993          	addi	s3,s7,8
 87e:	000bb903          	ld	s2,0(s7)
 882:	00090f63          	beqz	s2,8a0 <vprintf+0x25a>
        for(; *s; s++)
 886:	00094583          	lbu	a1,0(s2)
 88a:	c195                	beqz	a1,8ae <vprintf+0x268>
          putc(fd, *s);
 88c:	855a                	mv	a0,s6
 88e:	cf3ff0ef          	jal	580 <putc>
        for(; *s; s++)
 892:	0905                	addi	s2,s2,1
 894:	00094583          	lbu	a1,0(s2)
 898:	f9f5                	bnez	a1,88c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 89a:	8bce                	mv	s7,s3
      state = 0;
 89c:	4981                	li	s3,0
 89e:	bbcd                	j	690 <vprintf+0x4a>
          s = "(null)";
 8a0:	00000917          	auipc	s2,0x0
 8a4:	2a090913          	addi	s2,s2,672 # b40 <malloc+0x194>
        for(; *s; s++)
 8a8:	02800593          	li	a1,40
 8ac:	b7c5                	j	88c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 8ae:	8bce                	mv	s7,s3
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	bbf9                	j	690 <vprintf+0x4a>
 8b4:	64a6                	ld	s1,72(sp)
 8b6:	79e2                	ld	s3,56(sp)
 8b8:	7a42                	ld	s4,48(sp)
 8ba:	7aa2                	ld	s5,40(sp)
 8bc:	7b02                	ld	s6,32(sp)
 8be:	6be2                	ld	s7,24(sp)
 8c0:	6c42                	ld	s8,16(sp)
 8c2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8c4:	60e6                	ld	ra,88(sp)
 8c6:	6446                	ld	s0,80(sp)
 8c8:	6906                	ld	s2,64(sp)
 8ca:	6125                	addi	sp,sp,96
 8cc:	8082                	ret

00000000000008ce <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8ce:	715d                	addi	sp,sp,-80
 8d0:	ec06                	sd	ra,24(sp)
 8d2:	e822                	sd	s0,16(sp)
 8d4:	1000                	addi	s0,sp,32
 8d6:	e010                	sd	a2,0(s0)
 8d8:	e414                	sd	a3,8(s0)
 8da:	e818                	sd	a4,16(s0)
 8dc:	ec1c                	sd	a5,24(s0)
 8de:	03043023          	sd	a6,32(s0)
 8e2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ea:	8622                	mv	a2,s0
 8ec:	d5bff0ef          	jal	646 <vprintf>
}
 8f0:	60e2                	ld	ra,24(sp)
 8f2:	6442                	ld	s0,16(sp)
 8f4:	6161                	addi	sp,sp,80
 8f6:	8082                	ret

00000000000008f8 <printf>:

void
printf(const char *fmt, ...)
{
 8f8:	711d                	addi	sp,sp,-96
 8fa:	ec06                	sd	ra,24(sp)
 8fc:	e822                	sd	s0,16(sp)
 8fe:	1000                	addi	s0,sp,32
 900:	e40c                	sd	a1,8(s0)
 902:	e810                	sd	a2,16(s0)
 904:	ec14                	sd	a3,24(s0)
 906:	f018                	sd	a4,32(s0)
 908:	f41c                	sd	a5,40(s0)
 90a:	03043823          	sd	a6,48(s0)
 90e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 912:	00840613          	addi	a2,s0,8
 916:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91a:	85aa                	mv	a1,a0
 91c:	4505                	li	a0,1
 91e:	d29ff0ef          	jal	646 <vprintf>
}
 922:	60e2                	ld	ra,24(sp)
 924:	6442                	ld	s0,16(sp)
 926:	6125                	addi	sp,sp,96
 928:	8082                	ret

000000000000092a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92a:	1141                	addi	sp,sp,-16
 92c:	e422                	sd	s0,8(sp)
 92e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 930:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 934:	00000797          	auipc	a5,0x0
 938:	6cc7b783          	ld	a5,1740(a5) # 1000 <freep>
 93c:	a02d                	j	966 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 93e:	4618                	lw	a4,8(a2)
 940:	9f2d                	addw	a4,a4,a1
 942:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 946:	6398                	ld	a4,0(a5)
 948:	6310                	ld	a2,0(a4)
 94a:	a83d                	j	988 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 94c:	ff852703          	lw	a4,-8(a0)
 950:	9f31                	addw	a4,a4,a2
 952:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 954:	ff053683          	ld	a3,-16(a0)
 958:	a091                	j	99c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95a:	6398                	ld	a4,0(a5)
 95c:	00e7e463          	bltu	a5,a4,964 <free+0x3a>
 960:	00e6ea63          	bltu	a3,a4,974 <free+0x4a>
{
 964:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 966:	fed7fae3          	bgeu	a5,a3,95a <free+0x30>
 96a:	6398                	ld	a4,0(a5)
 96c:	00e6e463          	bltu	a3,a4,974 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 970:	fee7eae3          	bltu	a5,a4,964 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 974:	ff852583          	lw	a1,-8(a0)
 978:	6390                	ld	a2,0(a5)
 97a:	02059813          	slli	a6,a1,0x20
 97e:	01c85713          	srli	a4,a6,0x1c
 982:	9736                	add	a4,a4,a3
 984:	fae60de3          	beq	a2,a4,93e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 988:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 98c:	4790                	lw	a2,8(a5)
 98e:	02061593          	slli	a1,a2,0x20
 992:	01c5d713          	srli	a4,a1,0x1c
 996:	973e                	add	a4,a4,a5
 998:	fae68ae3          	beq	a3,a4,94c <free+0x22>
    p->s.ptr = bp->s.ptr;
 99c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 99e:	00000717          	auipc	a4,0x0
 9a2:	66f73123          	sd	a5,1634(a4) # 1000 <freep>
}
 9a6:	6422                	ld	s0,8(sp)
 9a8:	0141                	addi	sp,sp,16
 9aa:	8082                	ret

00000000000009ac <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ac:	7139                	addi	sp,sp,-64
 9ae:	fc06                	sd	ra,56(sp)
 9b0:	f822                	sd	s0,48(sp)
 9b2:	f426                	sd	s1,40(sp)
 9b4:	ec4e                	sd	s3,24(sp)
 9b6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b8:	02051493          	slli	s1,a0,0x20
 9bc:	9081                	srli	s1,s1,0x20
 9be:	04bd                	addi	s1,s1,15
 9c0:	8091                	srli	s1,s1,0x4
 9c2:	0014899b          	addiw	s3,s1,1
 9c6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9c8:	00000517          	auipc	a0,0x0
 9cc:	63853503          	ld	a0,1592(a0) # 1000 <freep>
 9d0:	c915                	beqz	a0,a04 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d4:	4798                	lw	a4,8(a5)
 9d6:	08977a63          	bgeu	a4,s1,a6a <malloc+0xbe>
 9da:	f04a                	sd	s2,32(sp)
 9dc:	e852                	sd	s4,16(sp)
 9de:	e456                	sd	s5,8(sp)
 9e0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9e2:	8a4e                	mv	s4,s3
 9e4:	0009871b          	sext.w	a4,s3
 9e8:	6685                	lui	a3,0x1
 9ea:	00d77363          	bgeu	a4,a3,9f0 <malloc+0x44>
 9ee:	6a05                	lui	s4,0x1
 9f0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9f4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9f8:	00000917          	auipc	s2,0x0
 9fc:	60890913          	addi	s2,s2,1544 # 1000 <freep>
  if(p == (char*)-1)
 a00:	5afd                	li	s5,-1
 a02:	a081                	j	a42 <malloc+0x96>
 a04:	f04a                	sd	s2,32(sp)
 a06:	e852                	sd	s4,16(sp)
 a08:	e456                	sd	s5,8(sp)
 a0a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a0c:	00000797          	auipc	a5,0x0
 a10:	60478793          	addi	a5,a5,1540 # 1010 <base>
 a14:	00000717          	auipc	a4,0x0
 a18:	5ef73623          	sd	a5,1516(a4) # 1000 <freep>
 a1c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a1e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a22:	b7c1                	j	9e2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a24:	6398                	ld	a4,0(a5)
 a26:	e118                	sd	a4,0(a0)
 a28:	a8a9                	j	a82 <malloc+0xd6>
  hp->s.size = nu;
 a2a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a2e:	0541                	addi	a0,a0,16
 a30:	efbff0ef          	jal	92a <free>
  return freep;
 a34:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a38:	c12d                	beqz	a0,a9a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a3c:	4798                	lw	a4,8(a5)
 a3e:	02977263          	bgeu	a4,s1,a62 <malloc+0xb6>
    if(p == freep)
 a42:	00093703          	ld	a4,0(s2)
 a46:	853e                	mv	a0,a5
 a48:	fef719e3          	bne	a4,a5,a3a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a4c:	8552                	mv	a0,s4
 a4e:	b1bff0ef          	jal	568 <sbrk>
  if(p == (char*)-1)
 a52:	fd551ce3          	bne	a0,s5,a2a <malloc+0x7e>
        return 0;
 a56:	4501                	li	a0,0
 a58:	7902                	ld	s2,32(sp)
 a5a:	6a42                	ld	s4,16(sp)
 a5c:	6aa2                	ld	s5,8(sp)
 a5e:	6b02                	ld	s6,0(sp)
 a60:	a03d                	j	a8e <malloc+0xe2>
 a62:	7902                	ld	s2,32(sp)
 a64:	6a42                	ld	s4,16(sp)
 a66:	6aa2                	ld	s5,8(sp)
 a68:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a6a:	fae48de3          	beq	s1,a4,a24 <malloc+0x78>
        p->s.size -= nunits;
 a6e:	4137073b          	subw	a4,a4,s3
 a72:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a74:	02071693          	slli	a3,a4,0x20
 a78:	01c6d713          	srli	a4,a3,0x1c
 a7c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a7e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a82:	00000717          	auipc	a4,0x0
 a86:	56a73f23          	sd	a0,1406(a4) # 1000 <freep>
      return (void*)(p + 1);
 a8a:	01078513          	addi	a0,a5,16
  }
}
 a8e:	70e2                	ld	ra,56(sp)
 a90:	7442                	ld	s0,48(sp)
 a92:	74a2                	ld	s1,40(sp)
 a94:	69e2                	ld	s3,24(sp)
 a96:	6121                	addi	sp,sp,64
 a98:	8082                	ret
 a9a:	7902                	ld	s2,32(sp)
 a9c:	6a42                	ld	s4,16(sp)
 a9e:	6aa2                	ld	s5,8(sp)
 aa0:	6b02                	ld	s6,0(sp)
 aa2:	b7f5                	j	a8e <malloc+0xe2>
