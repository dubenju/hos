/*
 * 
 *//*
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>


int main()
{
  struct stat fi;
  stat("/", &fi);
  printf("%d\n", fi.st_size);
  return 0;
}
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/stat.h>

int main(int argc, char **argv)
{
  struct stat      stat_buf;

  if (argc != 2) {
    fprintf(stderr, "main : ���s�������̐����s���ł�\n");
    exit(EXIT_FAILURE);
  }

  if (stat(*(argv + 1), &stat_buf) == 0) {
    /* �t�@�C������\�� */
    printf("�f�o�C�XID : %d\n",stat_buf.st_dev);
    printf("inode�ԍ� : %d\n",stat_buf.st_ino);
    printf("�A�N�Z�X�ی� : %o\n",stat_buf.st_mode);
    printf("�n�[�h�����N�̐� : %d\n",stat_buf.st_nlink);
    printf("���L�҂̃��[�UID : %d\n",stat_buf.st_uid);
    printf("���L�҂̃O���[�vID : %d\n",stat_buf.st_gid);
    printf("�f�o�C�XID�i����t�@�C���̏ꍇ�j : %d\n",stat_buf.st_rdev);
    printf("�e�ʁi�o�C�g�P�ʁj : %d\n",stat_buf.st_size);
    printf("�t�@�C���V�X�e���̃u���b�N�T�C�Y : %d\n",stat_buf.st_blksize);
    printf("���蓖�Ă�ꂽ�u���b�N�� : %d\n",stat_buf.st_blocks);
    printf("�ŏI�A�N�Z�X���� : %s",ctime(&stat_buf.st_atime));
    printf("�ŏI�C������ : %s",ctime(&stat_buf.st_mtime));
    printf("�ŏI��ԕύX���� : %s",ctime(&stat_buf.st_ctime));
 }
  else {
    perror("main ");
  }

  return EXIT_SUCCESS;
}