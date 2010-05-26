class Playlist
  def initialize(files)
    @files = files
    @ptr   = 0
  end

  def current
    return @files[@ptr]
  end

  def next!(n=1)
    @ptr = (@ptr + n) % @files.length
    return self.current
  end

  def prev!(n=1)
    @ptr = (@ptr - n) % @files.length
    return self.current
  end
end

