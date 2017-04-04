#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/platform_device.h>

#define KINPIRA_VERSION "1.0"

static int kinpira_probe(struct platform_device *pdev)
{
}

static int kinpira_remove(struct platform_device *pdev)
{
}

static const struct of_device_id kinpira_of_match[] = {
  {
    .compatible = "xlnx,kinpira-1.0",
  },
  {},
};

MODULE_DEVICE_TABLE(of, kinpira_of_match);

static struct platform_driver kinpira_driver = {
  .probe = kinpira_probe,
  .remove = kinpira_remove,
  .driver = {
    .name = "kinpira_driver",
    .of_match_table = of_match_ptr(kinpira_of_match),
  }
};

module_platform_driver(kinpira_driver);

MODULE_DESCRIPTION("Kinpira Driver");
MODULE_AUTHOR("Takayuki Ujiie <takau@easter.kuee.kyoto-u.ac.jp>");
MODULE_LICENSE("GPL");
MODULE_VERSION(KINPIRA_VERSION);
