class User < ApplicationRecord
  has_many :samples, foreign_key: :user_id, dependent: :destroy
  has_many :assigned_samples, class_name: 'Sample', foreign_key: :laboratorista_id, dependent: :destroy

  # TENANT
  belongs_to :tenant

  # Roles de usuario
  enum role: { cliente: 0, laboratorista: 1, admin: 2 }

  # Devise módulos para autenticación
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Validaciones
  validates :email, presence: true, uniqueness: { case_sensitive: false, message: 'El correo ya está registrado.' }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_required?
  validates :role, presence: true, inclusion: { in: roles.keys, message: 'El rol no es válido.' }

  private

  def password_required?
    new_record? || !password.blank?
  end
end
