require "json"

alias Config = Hash(String, Item)

class Item
  include JSON::Serializable

  @[JSON::Field(key: "selector")]
  property selector : String

  @[JSON::Field(key: "actions")]
  property actions : Array(XdotKeyAction)
end

class XdotKeyAction
  include JSON::Serializable
  @[JSON::Field(key: "key")]
  property key : String
end

def main
  if ARGV.size != 2
    puts "invalid input: xdotool-ext CONFIG_PATH COMMAND_NAME"
    return
  end

  config = Config.from_json(File.read(ARGV[0]))
  command = ARGV[1]
  item = config[command]

  system %(wmctrl -a "#{item.selector}")
  item.actions.each do |action|
    system %(xdotool key "#{action.key}")
  end
end

main()
