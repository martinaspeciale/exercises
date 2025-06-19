import random 

class Dataset:
    def __init__(self, name, data, labels):
        if not isinstance(data, list): 
            raise TypeError("data must be a list") 
        if not isinstance(labels, list):
            raise TypeError("labels must be a list)")

        if len(data) != len(labels):
            raise ValueError("data and labels must have the same length")
        
        if not all(isinstance(x,(int,float)) for x in data):
            raise TypeError("all data values must be numeric")
        
        if not all(isinstance(x,str) for x in labels):
            raise TypeError("all labels must be strings")
        self.name=name
        self.data=data
        self.labels=labels
    def summary(self):
        num_samples = len(self.data)
        mean_value = sum(self.data)/num_samples if num_samples>0 else 0
        print(f"Dataset: {self.name}")
        print(f"Number of samples: {num_samples}")
        print(f"Mean of data: {mean_value:.2f}")
    def add_sample(self, sample, label):
        self.data.append(sample)
        self.labels.append(label)
    def normalize(self):
        if not self.data:
            print("No data to normalize")
            return 
        min_val = min(self.data)
        max_val = max(self.data)

        if min_val == max_val:
            # all values are equal 
            self.data = [0.5 for _ in self.data]
            return 

        self.data = [(x-min_val)/(max_val-min_val) for x in self.data]

    def split_train_test(self, test_ratio):
        combined = list(zip(self.data, self.labels))
        random.shuffle(combined)

        test_size = int(len(combined)*test_ratio)

        test_set = combined[:test_size]
        train_set = combined[test_size:]

        train_data, train_labels = zip(*train_set) if train_set else ([],[])
        test_data, test_labels = zip(*test_set) if test_set else ([], [])

        train_dataset = Dataset("f{self.name}_train", list(train_data), list(train_labels))
        test_dataset = Dataset(f"{self.name}_test", list(test_data), list(test_labels))

        return train_dataset, test_dataset 


class ImageDataset(Dataset):
    def __init__(self, name, data, labels, image_size):
        super().__init__(self, name, data, labels)
        self.image_size=image_size
    
    def summary(self):
        super().summary()
        print(f"Image size: {self.image_size}")
