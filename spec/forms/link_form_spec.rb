# frozen_string_literal: true

RSpec.describe LinkForm, type: :form do
  shared_examples 'link form invalid' do
    it 'returns false' do
      is_expected.to be_falsy
    end

    it 'does not assign value of short_path' do
      subject
      expect(form.short_path).to be nil
    end
  end

  let(:form) { described_class.new }
  let(:params) do
    ActionController::Parameters.new(
      { original_url: original_url, custom_path: custom_path }
    ).permit!
  end
  let(:original_url) { 'https://test_long_long_long_long_url.test' }
  let(:custom_path) { '' }

  describe '#attributes=' do
    let(:link) { form.link }
    let(:link_custom) { form.link_custom }

    subject { form.attributes = params }

    context 'new original url' do
      it 'initializes new record of Link and assigns attributes' do
        subject
        expect(link).to be_a_kind_of(Link)
        expect(link.new_record?).to be_truthy
        expect(link.original_url).to eq(original_url)
      end

      context 'with custom path input' do
        let(:custom_path) { 'test_1' }

        it 'initializes new record of LinkCustom and assigns attributes' do
          subject
          expect(link_custom).to be_a_kind_of(LinkCustom)
          expect(link_custom.new_record?).to be_truthy
          expect(link_custom.short_path).to eq custom_path
        end
      end

      context 'without custom path input' do
        it 'does not initialize new record of LinkCustom' do
          subject
          expect(link_custom).to be nil
        end
      end
    end

    context 'persisted original url' do
      let!(:existed_link) do
        create :link,
               original_url: original_url
      end

      it 'finds the existed record of Link' do
        subject
        expect(link).to eq existed_link
      end

      context 'with custom path input' do
        context 'custom path is a existed short_path' do
          context 'find out in Link record' do
            let(:custom_path) { existed_link.short_path }

            it 'does not lookup records of LinkCustom' do
              subject
              expect(link_custom).to be nil
            end
          end

          context 'find out in LinkCustom record' do
            let!(:existed_link_custom) do
              create :link_custom, link: existed_link
            end

            let(:custom_path) { existed_link_custom.short_path }

            it 'finds the existed record of LinkCustom' do
              subject
              expect(link_custom).to eq existed_link_custom
            end
          end
        end

        context 'custom path is a new short_path' do
          let(:custom_path) { 'test_1' }

          it 'initializes new record of LinkCustom and assigns attributes' do
            subject
            expect(link_custom).to be_a_kind_of(LinkCustom)
            expect(link_custom.short_path).to eq custom_path
          end
        end
      end

      context 'without custom path input' do
        it 'does not initialize any new record of Link and LinkCustom' do
          subject
          expect(link.new_record?).to be_falsy
          expect(link_custom).to be nil
        end
      end
    end
  end

  describe '#save' do
    let!(:existed_link) do
      create :link,
             original_url: original_url
    end

    before { form.attributes = params }

    subject { form.save }

    context 'form is not changed' do
      it 'returns true' do
        is_expected.to be_truthy
      end

      it 'assigns value of short_path' do
        subject
        expect(form.short_path).to eq existed_link.short_path
      end
    end

    context 'form is changed' do
      let(:custom_path) { 'custom_path_1' }

      context 'is vaild and save' do
        it 'returns true' do
          is_expected.to be_truthy
        end

        it 'assigns value of short_path' do
          subject
          expect(form.short_path).to eq custom_path
        end
      end

      context 'is invalid' do
        let(:error_messages) { form.errors.messages }

        context 'original_url is not present' do
          let(:original_url) { '' }

          it_behaves_like 'link form invalid'

          it 'contains error message of original_url' do
            subject
            expect(form.errors.messages[:original_url]).to include("can't be blank")
          end
        end

        context 'original_url is already a short url' do
          let(:original_url) { 'http://localhost:3000/foo' }

          it_behaves_like 'link form invalid'

          it 'contains error message of original_url' do
            subject
            expect(form.errors.messages[:original_url]).to include('is already a short url')
          end
        end

        context 'original_url is not a valid url' do
          let(:original_url) { 'foo' }

          it_behaves_like 'link form invalid'

          it 'contains error message of original_url' do
            subject
            expect(form.errors.messages[:original_url]).to include('is not a url')
          end
        end

        context 'custom_path format is invalid' do
          let(:custom_path) { '11' }

          it_behaves_like 'link form invalid'

          it 'contains error message of custom_path' do
            subject
            expect(form.errors.messages[:custom_path])
              .to include('must start from 2 letters and accept letters, numbers, underscores and dashes only')
          end
        end

        context 'custom_path is not unique' do
          let!(:existed_link_custom) do
            create :link_custom
          end

          let(:custom_path) { existed_link_custom.short_path }

          it_behaves_like 'link form invalid'

          it 'contains error message of custom_path' do
            subject
            expect(form.errors.messages[:custom_path]).to include('has already been taken')
          end
        end
      end
    end
  end
end
