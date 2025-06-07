from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("WordCount").getOrCreate()

# Sample data (normally you'd read from S3)
data = ["hello world", "hello spark", "hello emr"]

rdd = spark.sparkContext.parallelize(data)
word_counts = (
    rdd.flatMap(lambda line: line.split())
       .map(lambda word: (word, 1))
       .reduceByKey(lambda a, b: a + b)
)

for word, count in word_counts.collect():
    print(f"{word}: {count}")

spark.stop()

