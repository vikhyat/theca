class Playlist
  def initialize(files)
    @files = files
    @ptr   = 0
  end

  def current_song; File.basename(self.current_file, ".mp3"); end
  def current_file; @files[@ptr];                             end

  # Go ahead n songs
  def next!(n=1)
    @ptr = (@ptr + n) % @files.length
    self.current_file
  end

  # Go back n songs
  def prev!(n=1)
    @ptr = (@ptr - n) % @files.length
    self.current_file
  end
end

