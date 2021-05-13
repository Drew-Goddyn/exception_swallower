RSpec.describe ExceptionSwallower do
  class PopGoesTheWeasel < StandardError;end

  class ExceptionSwallowerTestSubject
    include ExceptionSwallower
    swallow_exceptions PopGoesTheWeasel

    def no_boom
      raise PopGoesTheWeasel
    end

    def boom
      raise StandardError
    end

    def self.no_boom
      raise PopGoesTheWeasel
    end

    def self.boom
      raise StandardError
    end
  end

  context "class methods" do
    it "swallows defined exceptions" do
      expect{ ExceptionSwallowerTestSubject.no_boom }.to_not raise_error(PopGoesTheWeasel)
    end

    it "doesn't swallow normal exceptions" do
      expect{ ExceptionSwallowerTestSubject.boom }.to raise_error(StandardError)
    end
  end

  context "instance methods" do
    it "swallows defined exceptions" do
      expect{ ExceptionSwallowerTestSubject.new.no_boom }.to_not raise_error(PopGoesTheWeasel)
    end

    it "doesn't swallow normal exceptions" do
      expect{ ExceptionSwallowerTestSubject.new.boom }.to raise_error(StandardError)
    end
  end
end
