class Category
  def self.matches?(request)
    CATEGORIES.include?(request.params[:id])
  end

  CATEGORIES = ['microphones',
    'audio-interfaces',
    'mixers',
    'signal-processors',
    'keyboards-midi',
    'monitors-speakers',
    'headphones',
    'guitars',
    'effects-pedals',
    'amplifiers',
    'bass',
    'instruments',
    'drums-percussion',
    'dj',
    'computers',
    'software',
    'miscellaneous']
end
