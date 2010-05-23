# coding: utf-8


# TODO: better way of selecting files
path = ARGV[0]
files = Dir.new(path).entries - ['.', '..']
# primitive filtering
if not ARGV[1].nil?
  files = files.collect { |p| p[0..(ARGV[1].length-1)] == ARGV[1] ? p : nil  }.compact 
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
  t = $ptr % files.length
  print "#{files[t].split('.')[0]}\n\r"
  $p.puts "LOAD #{path}#{files[t]}"
  while (a=$p.gets) != "@P 0\n"
    if $break
      $break = false
      break
    end
  end
  $ptr += 1
end
