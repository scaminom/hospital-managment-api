require 'rails_helper'

RSpec.describe Patient do
  describe 'validations' do
    subject { build(:patient) }

    it { is_expected.to validate_presence_of(:insurance_number) }
    it { is_expected.to allow_value('123-ABC').for(:insurance_number) }
    it { is_expected.not_to allow_value('123ABC').for(:insurance_number) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(50) }

    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(50) }

    it { is_expected.to validate_presence_of(:date_of_birth) }

    it { is_expected.to validate_presence_of(:gender) }

    it {
      expect(subject).to validate_inclusion_of(:gender).in_array(Patient::VALID_GENDERS)
        .with_message('%<value>s is not a valid gender')
    }

    it { is_expected.to validate_presence_of(:address) }

    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to allow_value('1234567890').for(:phone_number) }
    it { is_expected.not_to allow_value('123456789').for(:phone_number) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }

    it { is_expected.to validate_presence_of(:blood_type) }
    it { is_expected.to validate_inclusion_of(:blood_type).in_array(Patient::VALID_BLOOD_TYPES) }

    describe 'custom validations' do
      context 'when patient is under 18' do
        it 'is invalid' do
          patient = build(:patient, date_of_birth: 17.years.ago)
          expect(patient).not_to be_valid
        end
      end

      it 'validates that the patient is at least 18 years old' do
        patient = build(:patient, date_of_birth: 17.years.ago)
        expect(patient.errors[:date_of_birth]).to include('patient must be 18 years old or older')
      end

      context 'when patient is 18 or older' do
        it 'is valid' do
          patient = build(:patient, date_of_birth: 18.years.ago)
          expect(patient).to be_valid
        end
      end
    end
  end

  describe 'callbacks' do
    describe '#normalize_attributes' do
      # rubocop:disable RSpec/MultipleExpectations
      it 'titleizes first_name and last_name before save' do
        patient = create(:patient, first_name: 'john', last_name: 'doe')
        expect(patient.first_name).to eq('John')
        expect(patient.last_name).to eq('Doe')
      end
    end
  end

  describe 'constants' do
    it 'has correct VALID_BLOOD_TYPES' do
      expect(Patient::VALID_BLOOD_TYPES).to eq(%w[A+ A- B+ B- AB+ AB- O+ O-])
    end

    it 'has correct VALID_GENDERS' do
      expect(Patient::VALID_GENDERS).to eq(%w[M F])
    end

    it 'has correct WHITELISTED_ATTRIBUTES' do
      expect(Patient::WHITELISTED_ATTRIBUTES).to eq(
        [:insurance_number, :first_name, :last_name, :date_of_birth,
         :gender, :address, :phone_number, :email,
         :blood_type, :allergies]
      )
    end
  end
end
