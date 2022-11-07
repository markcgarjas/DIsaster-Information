class UpdateDefaultTypesToTypes < ActiveRecord::Migration[7.0]
  def change
    Type.find_or_create_by(name: 'Covid')
    Type.find_or_create_by(name: 'Earthquake')
    Type.find_or_create_by(name: 'Typhoon')
  end
end
