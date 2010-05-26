class Player
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
end

