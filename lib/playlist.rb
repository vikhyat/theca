class Playlist
  def initialize(files)
    @files = files
    @ptr   = 0
  end

  def current_song
    File.basename(self.current_file, ".mp3")
  end

  def current_file
    return @files[@ptr]
  end

  def next!(n=1)
    @ptr = (@ptr + n) % @files.length
    return self.current_file
  end

  def prev!(n=1)
    @ptr = (@ptr - n) % @files.length
    return self.current_file
  end
end

