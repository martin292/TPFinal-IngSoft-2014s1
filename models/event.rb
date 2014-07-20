class Event
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :max, Integer
  property :date, DateTime, :required => true
  property :members, String
  property :slug, String
  property :short_url, String
  property :hay_notificaciones, Integer, :default  => 0
  property :tag, String
  belongs_to :account
  has n, :ratings
  before :save, :set_slug

  validates_with_method :check_date

  def nueva_evaluacion
    self.hay_notificaciones = 1
  end

  def chekear_evaluacion
    self.hay_notificaciones = 0
  end

  def hay_nuevas_evaluaciones
    return "Hay nuevas evaluaciones" if self.hay_notificaciones == 1
    return " " #No hay nuevas evaluaciones
  end

  def check_date
    return (self.date >= Date.today) if self.date.is_a?(Date)
    return false
  end

  def check_email
    result = true
    self.members.split(',').each do |mail|
      unless mail.strip =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/ || mail.strip == ""
        result =  false
        break
      end
    end
    return result
  end

  def positive_ratings_count
    self.ratings.all(:value => 1).size
  end

  def negative_ratings_count
    self.ratings.all(:value => -1).size
  end

  def neutral_ratings_count
    self.ratings.all(:value => 0).size
  end

  def average_ratings
    total_rates = self.positive_ratings_count + negative_ratings_count + neutral_ratings_count
    if total_rates == 0
      then return " - "
    else
      return (self.positive_ratings_count * 10 + negative_ratings_count * 0 + neutral_ratings_count * 5) / total_rates
    end
  end

  def set_slug
    self.slug = Event.generate_slug(@name) if self.new?
  end
  
  def slug
    set_slug if @slug.nil?
    @slug
  end

  def self.generate_slug(name, initial_count = 1)
    candidate_slug = name.gsub(' ', '')
    candidate_slug = "#{candidate_slug}#{initial_count}".downcase
    count = Event.all(:slug => candidate_slug).size
    if count == 0
      return candidate_slug 
    else
      return generate_slug(name, initial_count + 1)
    end
  end

end
