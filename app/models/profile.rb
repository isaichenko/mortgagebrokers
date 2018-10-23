class Profile < ApplicationRecord
  serialize :languages , Array
  serialize :mortgage_types, Array
  serialize :areas#, Hash
  belongs_to :package  , optional: true
  has_one_attached :license
  has_one_attached :id_proof_1
  has_one_attached :id_proof_2
  belongs_to :user  , optional: true
  validates :title, :company , :company_address , :description ,:mortgage_types,:languages, presence: true, if: :step1?
  #validate :broker_attachments?,if: :step2?
  validates :package_id,presence: true, if: :step3?
  attr_accessor :stripe_token

  include MultiStepModel

  def self.total_steps
    3
  end

  def broker_attachments?
    [license,id_proof_1,id_proof_2].each {|a|
        errors.add("#{a.name}".to_sym, "Please upload #{a.name}") if !a.attached?
        errors.add("#{a.name}".to_sym,'only jpg,jpeg,png,pdf files are allowed') if a.attached? && !a.blob.content_type.in?(%w(image/png image/jpeg image/jpeg application/pdf))
    }
  end

end