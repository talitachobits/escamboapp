class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :member

  #Validações
  validates :title, :description, :category,
              :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0}

  #Scopes
  # (quantity = 9), espera-se a quantity, mas se nada for passado o valor padrão é 9
  scope :descending_order, ->(quantity = 9) {limit(quantity).order(created_at: :desc)}
  scope :to_the, -> (member) {where(member: member).order(:created_at)}

  #configuração paperclip
    has_attached_file :picture, styles: { large: "823x365#", medium: "255x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  #gem money-rails
  monetize :price_cents
end
