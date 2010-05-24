#!/usr/bin/env ruby
# coding: utf-8

begin
  files = Dir.glob(ARGV[0])
  raise if files.length == 0
rescue
  puts "No files given."
  exit
end

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

$ptr = 0

$p = IO.popen("mpg123 -R dummytxt", "w+")

# used to allow changing to the next song
$break = false

Thread.new do
  loop do
    q = getch
    { 
      'p' => lambda { $p.puts "PAUSE" }, 
      'q' => lambda { $p.puts "QUIT"; exit },
      '.' => lambda { $break = true },
      ','  => lambda { $break = true; $ptr -= 2 }
    }[q].call
  end
end

loop do
  $ptr = $ptr % files.length
  print "#{files[$ptr].split('/')[-1].split('.mp3')[0]}\n\r"
  $p.puts "LOAD #{files[$ptr]}"
  while (a=$p.gets) != "@P 0\n"
    if $break
      $break = false
      break
    end
  end
  $ptr += 1
end
