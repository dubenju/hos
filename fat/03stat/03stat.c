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

// struct stat {
// dev_t st_dev; /* ID of device containing file */
// ino_t st_ino; /* inode number */
// mode_t st_mode; /* protection */
// nlink_t st_nlink; /* number of hard links */
// uid_t st_uid; /* user ID of owner */
// gid_t st_gid; /* group ID of owner */
// dev_t st_rdev; /* device ID (if special file) */
// off_t st_size; /* total size, in bytes */
// blksize_t st_blksize; /* blocksize for filesystem I/O */
// blkcnt_t st_blocks; /* number of blocks allocated */
// time_t st_atime; /* time of last access */
// time_t st_mtime; /* time of last modification */
// time_t st_ctime; /* time of last status change */
// }

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/stat.h>

int main(int argc, char **argv)
{
  struct stat      stat_buf;

  if (argc != 2) {
    printf("main : 実行時引数の数が不当です\n");
    exit(EXIT_FAILURE);
  }

  if (stat(*(argv + 1), &stat_buf) == 0) {
    /* ファイル情報を表示 */
    printf("デバイスID : %d\n",stat_buf.st_dev);
    printf("inode番号 : %d\n",stat_buf.st_ino);
    printf("アクセス保護 : %o\n",stat_buf.st_mode);
    printf("ハードリンクの数 : %d\n",stat_buf.st_nlink);
    printf("所有者のユーザID : %d\n",stat_buf.st_uid);
    printf("所有者のグループID : %d\n",stat_buf.st_gid);
    printf("デバイスID（特殊ファイルの場合） : %d\n",stat_buf.st_rdev);
    printf("容量（バイト単位） : %d\n",stat_buf.st_size);
//    printf("ファイルシステムのブロックサイズ : %d\n",stat_buf.st_blksize);
//    printf("割り当てられたブロック数 : %d\n",stat_buf.st_blocks);
    printf("最終アクセス時刻 : %s",ctime(&stat_buf.st_atime));
    printf("最終修正時刻 : %s",ctime(&stat_buf.st_mtime));
    printf("最終状態変更時刻 : %s",ctime(&stat_buf.st_ctime));
 }
  else {
    perror("main ");
  }

  return EXIT_SUCCESS;
}
