# en 
# what the problem xdotool-ext want to solve
when we use xdotool to automate some of our actions, normally for each action we write a script,consuquence we have to write a bunch of scripts, it get hard to manipulate,xdotool-ext want to use a JSON file a describe a group of actions you want to do. for example, you could have a lot of group in wavebox,and each group could have a lot of sub-app,we could use some config like
```json
{
    "gmail": {
        "selector": "wavebox",
        "actions": [
            {
                "key": "Alt+4"
            },
            {
                "key": "Alt+Shift+1"
            }
        ]
    }
}
```
then,`xdotool-ext ./config.json gmail`to jump to the sub app you want to use.

## how it work
it quit simple, so i just left my code here
```crystal
  config = Config.from_json(File.read(ARGV[0]))
  command = ARGV[1]
  item = config[command]

  system %(wmctrl -a "#{item.selector}")
  item.actions.each do |action|
    system %(xdotool key "#{action.key}")
  end
  puts item

```
# ch
## xdotool 想解决的问题是什么
当对一个窗口利用xdotool进行自动化操作时,我们对我们想要做的每个事情写一个脚本,但如果脚本一多维护起来就比较麻烦，如果用bash去写switch的逻辑，那也蛮麻烦的，xdotool-ext就是希望能够用json配置文件来将对一个窗口的所有操作统一起来,举一个例子，wavebox中有许多的分组和子app,我们就可以使用如下的配置文件
```json
{
    "gmail": {
        "selector": "wavebox",
        "actions": [
            {
                "key": "Alt+4"
            },
            {
                "key": "Alt+Shift+1"
            }
        ]
    }
}
```
然后用`xdotool-ext ./config.json gmail`来直接切换到对应的app上
## 他是如何工作的
```crystal
  config = Config.from_json(File.read(ARGV[0]))
  command = ARGV[1]
  item = config[command]

  system %(wmctrl -a "#{item.selector}")
  item.actions.each do |action|
    system %(xdotool key "#{action.key}")
  end
  puts item
```