# coding: utf-8

require 'active_model'
require 'spec_helper'

require File.expand_path('lib/url')

class MockModel
  include ActiveModel::Validations
  attr_accessor :uri
end


describe UriValidator do
  let(:validatable_model) do
    Class.new MockModel do
      validates :uri, :uri => true
    end
  end

  it 'should be connected to model field' do
    expect { validatable_model.new }.to_not raise_error
  end

  describe 'should validates format' do
    subject { validatable_model.new }

    before { stub_request(:any, /.*/) }

    context 'for valid uri' do
      before { subject.stub(:uri).and_return('http://www.yandex.ru') }

      it { should be_valid }
    end

    context 'for valid uri with slash' do
      before { subject.stub(:uri).and_return('http://example.com/') }

      it { should be_valid }
    end

    context 'for valid uri with port' do
      before { subject.stub(:uri).and_return('http://ruby.on.rails:8000') }

      it { should be_valid }
    end

    context 'for valid uri with auth' do
      before { subject.stub(:uri).and_return('http://user:password@secret.site') }

      it { should be_valid }
    end

    context 'for invalid uri' do
      before { subject.stub(:uri).and_return(':(') }

      it { should have(1).error_on(:uri) }
      it { subject.error_on(:uri).should include('invalid uri') }
    end

    context 'for uri with not http scheme' do
      before { subject.stub(:uri).and_return('ftp://test.net') }

      it { should have(1).error_on(:uri) }
      it { subject.error_on(:uri).should include('invalid scheme') }
    end

    context 'for uri without scheme' do
      before { subject.stub(:uri).and_return('lookmart.ru/catalog') }

      it { should have(1).error_on(:uri) }
      it { subject.error_on(:uri).should include('invalid uri') }
    end
  end

  describe 'should validates access' do
    subject { validatable_model.new }

    before { subject.stub(:uri).and_return('http://test.com') }

    context 'to existing uri with 200 status' do
      before { stub_request(:any, 'http://test.com').to_return(:status => 200) }

      it { should be_valid }
    end

    context 'to existing uri with non 200 status' do
      before { stub_request(:any, 'http://test.com').to_return(:status => 301) }

      it { should have(1).error_on(:uri) }
      it { subject.error_on(:uri).should include('invalid status') }
    end

    context 'to nonexisting uri' do
      before { stub_request(:any, 'http://test.com').to_return(:status => 404) }

      it { should have(1).error_on(:uri) }
      it { subject.error_on(:uri).should include('invalid status') }
    end

    context 'to unresponsive uri' do
      before { stub_request(:any, 'http://test.com').to_timeout }

      it { should have(1).error_on(:uri) }
      it { subject.error_on(:uri).should include('invalid timeout') }
    end
  end
end
