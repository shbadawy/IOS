import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/mac/Desktop/twitter-sanders-apple3.csv"))

let (trainingData,testingData) = data.randomSplit(by: 0.8, seed: 5)

let classifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

//let accuricy = e

let metadata = MLModelMetadata(author: "Shimaa Badawy", shortDescription: "A model for predicting sentimints", version: "1.0")

try classifier.write(to: URL(fileURLWithPath: "/Users/mac/Desktop/SentimeentClassifier.mlmodel"))
