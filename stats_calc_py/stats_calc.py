import sys
from collections import Counter

class StatisticsCalculator:

    def __init__(self, nums):
        nums.sort() # Use library sort to sort numbers
        self.nums = nums

    def get_mean(self):
        total = sum(self.nums)
        return total / len(self.nums)

    def get_median(self):
        return self.nums[len(self.nums)//2]

    def get_mode(self):
        counter = Counter(self.nums) # Counter will count occurrances of numbers
        # Find the first number with the max occurance
        return counter.most_common(1)[0][0]

if __name__ == "__main__":
    # Check args

    nums = list(map(int, sys.argv[1:]))
    
    if len(nums) == 0:
        print(f"Usage: python {sys.argv[0]} <numbers>")
        sys.exit(1)

    stats_calc = StatisticsCalculator(nums)

    print(f"Mean: {stats_calc.get_mean():.2f}")
    print(f"Median: {stats_calc.get_median()}")
    print(f"Mode: {stats_calc.get_mode()}")
