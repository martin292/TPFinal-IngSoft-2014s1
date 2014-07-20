require 'spec_helper'
require 'date'

describe Event do

  describe 'set_slug' do

    it 'should assign downcase slug' do
      Event.should_receive(:all).with(:slug => 'myevent1').and_return([])
      event1 = Event.new
      event1.name ='my Event'
      event1.date = Date.today
      event1.set_slug
      event1.slug.should eq 'myevent1'
    end

    it 'should assign unique slug' do
      Event.should_receive(:all).with(:slug => 'myevent1').and_return([mock()])
      Event.should_receive(:all).with(:slug => 'myevent2').and_return([])
      event1 = Event.new
      event1.name ='my event'
      event1.date = Date.today
      event1.set_slug
      event1.slug.should eq 'myevent2'
    end

  end

  describe 'positive_ratings_count' do

    it 'should return 0 when there are no ratings' do
      event = Event.new
      event.positive_ratings_count.should eq 0
    end

    it 'should return 0 when there are no positive ratings' do
      event = Event.new
      rating = Rating.for_event(event)
      rating.value = -1
      event.ratings.push(rating)
      event.positive_ratings_count.should eq 0
    end

    it 'should return 2 when there 2 positive ratings and 1 negative' do
      event = Event.new
      rating = Rating.for_event(event)
      rating.value = -1
      event.ratings.push(rating)

      rating = Rating.for_event(event)
      rating.value = 1
      event.ratings.push(rating)


      rating = Rating.for_event(event)
      rating.value = 1
      event.ratings.push(rating)

      event.positive_ratings_count.should eq 2
      event.negative_ratings_count.should eq 1
      event.neutral_ratings_count.should eq 0
    end

  end

  describe 'check_date' do

    it 'should return false if date is before today' do
      event1 = Event.new
      event1.name ='my event'
      event1.date = Date.today-1
      event1.check_date.should be false
    end

    it 'should return true if date is today' do
      event1 = Event.new
      event1.name ='my event'
      event1.date = Date.today
      event1.check_date.should be true
    end


    it 'should return true if date is after today' do
      event1 = Event.new
      event1.name ='my event'
      event1.date = Date.today+1
      event1.check_date.should be true
    end

    it 'should return false if date is not valid' do
      event1 = Event.new
      event1.name ='my event'
      event1.date = 'text'
      event1.check_date.should be false
    end

  end

  describe 'average_ratings' do

    it 'should return " - " if the event did not receive ratings' do 
      event = Event.new
      event.average_ratings.should eq " - "
    end
    
    it 'should return 0 if the event receive a negative rating' do
      event = Event.new
      rating = Rating.for_event(event)
      rating.value = -1
      event.ratings.push(rating)
      
      event.average_ratings.should eq 0
    end

    it 'should return 5 if the event receive a neutral rating' do
      event = Event.new
      rating = Rating.for_event(event)
      rating.value = 0
      event.ratings.push(rating)
      
      event.average_ratings.should eq 5
    end

    it 'should return 10 if the event receive a positive rating' do
      event = Event.new
      rating = Rating.for_event(event)
      rating.value = 1
      event.ratings.push(rating)
      
      event.average_ratings.should eq 10
    end

    it 'should return 6 if the event receive 2 positive ratings, 1 neutral rating and a 1 negative rating' do
      event = Event.new
      rating = Rating.for_event(event)
      rating.value = -1
      event.ratings.push(rating)
      
      rating2 = Rating.for_event(event)
      rating2.value = 0
      event.ratings.push(rating2)

      rating3 = Rating.for_event(event)
      rating3.value = 1
      event.ratings.push(rating3)

      rating4 = Rating.for_event(event)
      rating4.value = 1
      event.ratings.push(rating4)

      event.average_ratings.should eq 6
    end
  end

end
