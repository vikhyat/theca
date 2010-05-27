class Player
  STOP_SIGNAL = "@P 0\n"

  def initialize
    @p = IO.popen("mpg123 -R dummytxt", "w+")
  end

  def load(file)
    @p.puts "LOAD #{file}"
  end

  def pause
    @p.puts "PAUSE"
  end

  def quit
    @p.puts "QUIT"
  end

  def gets
    @p.gets
  end

  # start playing and return after we're done.
  def play(file)
    self.load(file)
    while self.gets != STOP_SIGNAL
      ($break = false; break) if $break
    end
  end
end

