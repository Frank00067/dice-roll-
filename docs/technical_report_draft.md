# ALU Venture Link - Technical Report Draft

## Project Overview
ALU Venture Link is a Flutter mobile application designed to connect ALU students with internship opportunities from student-led startups and early-stage ventures. The app focuses on verified startups, searchable opportunities, and simple application workflows that are realistic for the ALU ecosystem.

## Architecture
- Flutter front end with a modern Material 3 UI.
- Provider-based state management for opportunities, searches, bookmarks, and application actions.
- A clear separation between models, screens, widgets, and state.

## Firebase Roadmap
The current version uses a local in-memory data model and is structured so Firebase Authentication, Firestore, and Cloud Functions can be integrated next. The app is ready to be extended with:
- Firebase Authentication for sign-in and onboarding.
- Firestore for startup profiles and opportunity documents.
- Real-time listeners for dynamic updates.

## Key Screens
1. Onboarding screen for the ALU student experience.
2. Opportunities home screen with search and cards.
3. Interactive actions for bookmarking and applying.

## Scalability and Maintainability
- State is centralized in one change notifier.
- UI components are modular and reusable.
- The project is organized into feature-focused folders for future growth.

## Challenges and Lessons Learned
- The project began as a simple dice app, so the main challenge was reorienting it into a full product experience.
- The app now demonstrates a realistic architecture foundation for a final submission.
- Future work should focus on Firebase integration, authentication, and real-time backend sync.
