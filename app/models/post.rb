class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]} # %w("Fiction"), %w("Non-Fiction")
    validate :clickbait?

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def clickbait?
        if CLICKBAIT_PATTERNS.none? {|pattern| pattern.match title}
            errors.add(:title, "must be clickbait")
            #dont need else because they're on their own lines
        end
    end
end
