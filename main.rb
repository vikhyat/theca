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
      'n' => lambda { $break = true }
    }[q].call
  end
end

loop do
  t = $ptr % files.length
  print "#{files[t]}\n\r"
  $p.puts "LOAD #{path}#{files[t]}"
  while (a=$p.gets) != "@P 0\n"
    if $break
      $break = false
      break
    end
  end
  $ptr += 1
end
