import threading # multiple threads but one single cpu
import multiprocessing # multiple cpus
import time


def worker(name):
    print(f"Thread {name} started")
    time.sleep(1)
    print(f"Thread {name} finished")

threads = [threading.Thread(target=worker, args=(i,)) for i in range(3)]
for t in threads:
    t.start()
for t in threads:
    t.join()


def square(x):
    return x * x

if __name__ == '__main__':
    with multiprocessing.Pool(processes=3) as pool:
        print(pool.map(square, [1, 2, 3, 4, 5]))
