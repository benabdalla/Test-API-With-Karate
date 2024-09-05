package karateTestApi;

import java.util.concurrent.atomic.AtomicInteger;

public class Main {

        private static AtomicInteger atomicInt = new AtomicInteger(0);

        public static void main(String[] args) {
            // Increment and get the new value
            int newValue = atomicInt.incrementAndGet();
            System.out.println("New Value after increment: " + newValue);

            // Decrement and get the new value
            newValue = atomicInt.decrementAndGet();
            System.out.println("New Value after decrement: " + newValue);

            // Add a value and get the new value
            newValue = atomicInt.addAndGet(10);
            System.out.println("New Value after adding 10: " + newValue);

            // Compare and set the value
            boolean isUpdated = atomicInt.compareAndSet(10, 20);
            System.out.println("Was the value updated? " + isUpdated);
            System.out.println("Current Value: " + atomicInt.get());
        }
    }


