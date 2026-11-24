/*
 * binary_search.cpp
 * ----------------------------------------------------------------------------
 * Iterative binary search over a sorted std::vector<int>.
 *
 *   - binarySearch(arr, target) returns the index of `target`, or -1.
 *   - main() asks the user for a number and reports whether (and where) it
 *     was found in a hard-coded sorted array.
 *   - Time complexity O(log n), extra space O(1).
 *
 * Build : g++ -std=c++17 -Wall -Wextra -pedantic -o bin/binary_search src/binary_search.cpp
 * Run   : ./bin/binary_search
 * ----------------------------------------------------------------------------
 */
#include <iostream>
#include <vector>
using namespace std;

// The Function
int binarySearch(const vector<int>& arr, int target) {
    int left = 0;
    int right = arr.size() - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        // Check if is in the middle
        if (arr[mid] == target) {
            return mid; // Target found, return its position
        }
        // Check if is in the lower middle
        else if (arr[mid] < target) {
            left = mid + 1;
        }
        // Check if is in the upper middle
        else {
            right = mid - 1;
        }
    }

    return -1; // Not found
}

int main() {
    // The array
    vector<int> arr = {-1, 5, 6, 18, 19, 25, 46, 78, 102, 114};

    // Number
    int target;
    cout << "Enter the number to search: ";
    cin >> target;

    // Binary search
    int position = binarySearch(arr, target);

    // Result
    if (position != -1) {
        cout << "Number " << target << " found at position " << position << "." << endl;
    } else {
        cout << "Number " << target << " not found in the given array." << endl;
    }

    return 0;
}
