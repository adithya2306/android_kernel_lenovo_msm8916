#ifndef _LINUX_DROP_CACHES_H
#define _LINUX_DROP_CACHES_H
#include <linux/fs.h>

void drop_pagecache_sb(struct super_block *sb, void *unused);
void drop_slab(void);
extern int sys_sync(void);

#endif