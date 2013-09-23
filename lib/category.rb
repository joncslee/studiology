class Category
  def self.matches?(request)
    CATEGORIES.keys.include?(request.params[:id])
  end
end
