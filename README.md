### Summary: Include screen shots or a video of your app highlighting its features

* Main recipe list view with thumbnail images
* Context menu showing YouTube and source options
* Error states and loading states
* Image loading states

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I implemented a hybrid caching solution using both NSCache for in-memory performance and SwiftData for persistence.
This approach ensures quick access to frequently used images while maintaining data across app launches.
I used SwiftData as it's Apple's newest persistence framework.
I implemented error handling throughout the network stack and surfaced error messages and recovery options to the user.
Added loading states and placeholders for better user feedback.
I focused focused on graceful degradation for when network requests might fail
I used the MVVM architecture to separate concerns and created reusable components for image loading.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Total time: 6 hours

Breakdown:

Initial setup and basic networking: 1hr

UI Implementation: 2hrs

Caching system: 2hrs

Error handling and edge cases: 1hr


### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I chose SwiftData over CoreData for its modern Swift-first approach.

Trade-offs are that it is less mature than CoreData, but better aligned with the future of Swift development.

I used singleton pattern for NetworkController to simplify state management

Trade-offs are that it is less testable, but appropriate for the project scope and timeline.
With more time it would make sence to mock out URLSession to better test the network controller

Image Caching Strategy

Implemented dual-layer caching (memory + disk).
This allowed better in app performance but is more complex than on disk only cacheing, while also providing persistance across app launches so that I do not having to fetch images multipul times

### Weakest Part of the Project: What do you think is the weakest part of your project?

Testing Coverage

Limited unit test coverage due to time constraints.
The app would benefit from network layer tests. As mentioned above, properly mocking URLSession would allow for more flexibility in testing and better coverage including view model tests.

Image Cache Management

The project currently lacks a cache eviction policy and there is no limit on disk usage.
I would implement cleanup based on age and size in production. Given the static nature of the json files used for this project this shouldn't be a huge issue for this app specifically, but in the real world this could start to use up memory and disk.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I thank you for taking time to review this project and would appreciate any feed back on how I could improve in the future.