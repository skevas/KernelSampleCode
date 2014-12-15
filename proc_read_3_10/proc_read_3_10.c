#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/sched.h>
#include <asm/uaccess.h>
#include <linux/seq_file.h>

int len,temp;
char *msg;

struct proc_dir_entry *proc_file_entry0;
struct proc_dir_entry *proc_file_entry1;

#define FILE0 "hello0"
#define FILE1 "hello1"

// Variant 0

int 
proc_show(struct seq_file *m, void *v)
{
	seq_printf(m, "%s\n",msg);
	return 0;
}

int
proc_open(struct inode *inode, struct file *file)
{
	return single_open(file, proc_show, NULL);
}

static const struct file_operations proc1_fops = {
	.owner		= THIS_MODULE,
	.open		= proc_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= single_release,
};

// Variant 1

int 
read_proc(struct file *filp,char *buf,size_t count,loff_t *offp ) 
{
	int copy_result;

	if(count>temp)
	{
		count=temp;
	}
	temp=temp-count;

	copy_result = copy_to_user(buf,msg, count);
	if(copy_result) {
		printk(KERN_INFO "Copy failed %d", copy_result);
	}

	if(count==0)
	temp=len;

	return count;
}

struct file_operations proc_fops = {
	.read = read_proc,
};

void
create_new_proc_entry(void) 
{
	proc_file_entry0 = proc_create(FILE0,0,NULL,&proc_fops);

	len=strlen(msg);
	temp=len;
}

// Init

int 
proc_init (void) {
	msg=" Hello World ";

	create_new_proc_entry();
	if(!proc_file_entry0) {
		printk(KERN_INFO "Create 0 failed\n");
		return -EPERM;
	}

	proc_file_entry1 = proc_create(FILE1, 0, NULL, &proc1_fops);
	if(!proc_file_entry1) {
		printk(KERN_INFO "Create 1 failed\n");
		return -EPERM;
	}

	return 0;
}

void proc_cleanup(void) {
	remove_proc_entry(FILE0,NULL);
	remove_proc_entry(FILE1,NULL);
}

MODULE_LICENSE("GPL"); 
module_init(proc_init);
module_exit(proc_cleanup);
