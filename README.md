
# SynchroSound Project

SynchroSound is a unique app that recommends music based on the user's mood, detected via facial expressions or selected images. Below is an overview of the user experience, illustrating how each screen flows into the next.

---

### Start Here: **Mood Detection Screen**

1. **Scan or Select Image**  
   The user starts by either scanning their face or selecting a photo from their camera roll. The app analyzes the image for emotions like joy, sadness, anger, and surprise.

   ⬇️ *Clicking 'Analyze' leads to...* ⬇️

---

### Next Up: **Mood Breakdown View**

![Mood Breakdown View](./path_to_images/MoodBreakDownView.png)

- **Mood Breakdown View** displays a visual breakdown of the emotions detected in the scanned or selected photo. The user can see how their emotional state is divided across categories like joy, sadness, anger, etc.
- The graph is displayed in a modern, futuristic style.

⬇️ *Clicking 'See Recommended Songs' leads to...* ⬇️

---

### Explore Recommendations: **Song View**

![Song View](./path_to_images/SongView.png)

- **Song View** presents a list of songs that match the user's detected emotions.
- Each song comes with its **album artwork**, **song title**, and the ability to play a preview.
- The songs are tailored to the emotional state as analyzed by the app.

⬇️ *Clicking on a song leads to...* ⬇️

---

### Dive Deeper: **Song Detail View**

![Song Detail View](./path_to_images/SongDetailView.png)

- **Song Detail View** provides an in-depth look at the selected song.
- Users can view song attributes such as **tempo**, **energy**, and **valence**, which are mapped from their emotions.
- The view also allows the user to see **album details**, and they can **play a preview** of the track directly from this screen.

⬇️ *Clicking 'Back' returns to...* ⬇️

---

### Returning to the **Song View**

From here, users can continue exploring recommended songs or return to the mood breakdown to restart the scanning process.

---

## How It Works

### Emotion Detection
SynchroSound integrates with the **Google Cloud Vision API** to detect emotions from images. These emotions are processed and mapped to **Spotify song attributes** such as valence (positivity), energy, and danceability.

### Song Recommendation
SynchroSound uses the **Spotify API** to pull song data and recommend tracks based on the user's emotional state. For example:
- **Joy** might map to high-energy, upbeat songs.
- **Sadness** could lead to slower, more mellow tracks.

---

## Installation & Setup

1. **Clone the repository**:
    ```bash
    git clone https://github.com/your-repository/synchrosound.git
    cd synchrosound
    ```

2. **Setup API Keys**:
    - Add your **Google Cloud Vision API Key** to enable emotion detection.
    - Add your **Spotify API Key** for fetching music recommendations.

3. **Build and Run**:
    - Open the project in Xcode.
    - Build the app and run it on your preferred simulator or device.

---

## Future Features
- **User Account Management**: Users will be able to edit and save their profiles, including favorite songs and genres.
- **Enhanced Search and Filter**: Allows users to search and filter recommended songs based on genre or mood.
- **Emotion History**: A feature that tracks the user's emotional state over time, giving insights into mood trends.

---

## Contributors
- **Feolu Kolawole**: Lead Developer

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
