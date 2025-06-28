// statistics.c
// This C program calculates mean, median, and mode from a list of integers.
// Implements a procedural approach using arrays and standard C functions.

#include <stdio.h>
#include <stdlib.h>

// Comparison function for qsort
int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

// Function to calculate mean
float mean(int arr[], int n) {
    int sum = 0;
    for(int i = 0; i < n; i++) sum += arr[i];
    return (float)sum / n;
}

// Function to calculate median
float median(int arr[], int n) {
    qsort(arr, n, sizeof(int), compare); // Sort the array
    if(n % 2 == 0)
        return (arr[n/2 - 1] + arr[n/2]) / 2.0;
    else
        return arr[n/2];
}

// Function to calculate and print mode
void mode(int arr[], int n) {
    int maxCount = 0;
    printf("Mode(s): ");
    for(int i = 0; i < n; i++) {
        int count = 1;
        for(int j = i+1; j < n; j++) {
            if(arr[j] == arr[i]) count++;
        }
        if(count > maxCount) maxCount = count;
    }

    // Print all modes with max frequency
    for(int i = 0; i < n; i++) {
        int count = 1;
        for(int j = i+1; j < n; j++) {
            if(arr[j] == arr[i]) count++;
        }
        if(count == maxCount) {
            printf("%d ", arr[i]);
        }
    }
    printf("\n");
}

int main() {
    int arr[] = {1, 3, 2, 4, 2, 5, 2};  // Example dataset
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("Mean: %.2f\n", mean(arr, n));
    printf("Median: %.2f\n", median(arr, n));
    mode(arr, n);

    return 0;
}
