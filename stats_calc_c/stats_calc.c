#include <stdio.h>
#include <stdlib.h>

// Compare function for sort
int compare(const void* a, const void* b) {
  return *(int*)a - *(int*)b;
}

int main(int argc, char** argv) {

  if(argc < 2) {
    printf("Usage: %s <integers>\n", argv[0]);

    return -1;
  }

  int num_count = argc - 1;

  int* nums = malloc(num_count * sizeof(int));

  for(int i = 0; i < num_count; i++) {
    nums[i] = atoi(argv[i + 1]);
    // printf("%d\n", nums[i]);
  }

  // Sort using library sort
  qsort(nums, num_count, sizeof(int), compare);

  double sum = 0.0 + nums[0];
  int most_freq = nums[0];
  int last = 1;
  int most_freq_count = 1;
  for(int i = 1; i < num_count; i++) {
    sum += nums[i];
    if(nums[i] == nums[i-1]) {
      last += 1;
    } else {
      if(last > most_freq_count) {
        most_freq_count = last;
        most_freq = nums[i - 1];
      }
      last = 1;
    }
  }

  if(last > most_freq_count) {
    most_freq_count = last;
    most_freq = nums[num_count - 1];
  }
  
  int mid = nums[num_count / 2];
  printf("Mean: %.2f\n", sum/(num_count));
  printf("Median: %d\n", mid);
  printf("Mode: %d\n", most_freq);

  free(nums);

  nums = NULL;
  
  return 0;
}
