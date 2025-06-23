import java.util.concurrent.*;
import java.util.*;
import java.io.*;

// Author: Nabin
public class RideSharingSystem {

    // Shared task queue
    private final BlockingQueue<String> taskQueue = new LinkedBlockingQueue<>();

    // Shared result list
    private final List<String> resultList = Collections.synchronizedList(new ArrayList<>());

    // Logger to track system events
    private final PrintWriter logger;

    public RideSharingSystem() throws IOException {
        logger = new PrintWriter(new FileWriter("log_java.txt"), true);
    }

    // Adds tasks to the shared queue
    public void addTask(String task) {
        taskQueue.offer(task);
    }

    // Worker class implementing Runnable
    class Worker implements Runnable {
        private final int id;

        public Worker(int id) {
            this.id = id;
        }

        @Override
        public void run() {
            logger.println("Thread " + id + " started.");
            while (true) {
                try {
                    String task = taskQueue.poll(1, TimeUnit.SECONDS);
                    if (task == null) break; // Exit when no tasks are left
                    // Simulate processing
                    Thread.sleep(500);
                    String result = "Thread " + id + " processed: " + task;
                    resultList.add(result);
                    logger.println(result);
                } catch (InterruptedException e) {
                    logger.println("Thread " + id + " interrupted.");
                    Thread.currentThread().interrupt();
                } catch (Exception e) {
                    logger.println("Thread " + id + " error: " + e.getMessage());
                }
            }
            logger.println("Thread " + id + " finished.");
        }
    }

    public void execute(int numberOfThreads) {
        ExecutorService executor = Executors.newFixedThreadPool(numberOfThreads);
        for (int i = 0; i < numberOfThreads; i++) {
            executor.execute(new Worker(i));
        }
        executor.shutdown();
        try {
            executor.awaitTermination(5, TimeUnit.MINUTES);
        } catch (InterruptedException e) {
            logger.println("Executor interrupted: " + e.getMessage());
        }

        // Save results
        try (PrintWriter out = new PrintWriter("results_java.txt")) {
            for (String res : resultList) {
                out.println(res);
            }
        } catch (IOException e) {
            logger.println("Failed to save results: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try {
            RideSharingSystem system = new RideSharingSystem();

            // Add tasks to the queue
            for (int i = 1; i <= 20; i++) {
                system.addTask("Ride Request " + i);
            }

            // Start system with 4 worker threads
            system.execute(4);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
