# statistics_calculator.py
# This Python program uses object-oriented programming (OOP) to compute mean, median, and mode.

from collections import Counter

class StatisticsCalculator:
    def __init__(self, data):
        self.data = sorted(data)  # Sort once for median and mode efficiency

    def mean(self):
        """Calculate the mean (average) of the list."""
        return sum(self.data) / len(self.data)

    def median(self):
        """Calculate the median (middle value) of the list."""
        n = len(self.data)
        mid = n // 2
        if n % 2 == 0:
            return (self.data[mid - 1] + self.data[mid]) / 2
        else:
            return self.data[mid]

    def mode(self):
        """Calculate the mode(s): most frequent value(s) in the list."""
        freq = Counter(self.data)
        max_count = max(freq.values())
        return [k for k, v in freq.items() if v == max_count]

# Sample usage
if __name__ == "__main__":
    data = [1, 3, 2, 4, 2, 5, 2]
    stats = StatisticsCalculator(data)

    print(f"Mean: {stats.mean():.2f}")
    print(f"Median: {stats.median():.2f}")
    print(f"Mode(s): {stats.mode()}")
