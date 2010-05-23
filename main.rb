# coding: utf-8

path = "/home/vikhyat/Music/" # ARGV[0]
files = Dir.new(path).entries - ['.', '..']

files = (Dir.new(path).entries - ['.', '..']).collect { |p| p[0..2] == "YUI" ? p : nil  }.compact

def getch
  begin
    system("stty raw -echo")
    str = STDIN.getc
  ensure
    system("stty -raw echo")
  end
  return str
end

files = files.sort_by { rand }

ptr = 0

$p = IO.popen("mpg123 -R dummytxt", "w+")

loop do
  t = ptr % files.length
  puts files[t]
  $p.puts "LOAD #{path}#{files[t]}"
  while (a=$p.gets) != "@P 0"
    # do nothing
  end
  ptr += 1
end
