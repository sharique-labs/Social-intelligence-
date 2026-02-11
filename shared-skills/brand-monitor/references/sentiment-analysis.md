# Sentiment Analysis Guide

## Sentiment Classification

### Five-Point Scale

| Level | Label | Indicators | Examples |
|-------|-------|-----------|---------|
| +2 | Strong Positive | Active advocacy, recommendation, enthusiasm | "Best tool I've ever used", "Everyone needs this", "Just convinced my whole team to switch" |
| +1 | Positive | Praise, satisfaction, mild endorsement | "Really liking this", "Works well for me", "Good experience so far" |
| 0 | Neutral | Informational mention, question, sharing without opinion | "Has anyone tried X?", "X just announced Y", "Comparing X and Y" |
| -1 | Negative | Complaint, disappointment, frustration | "Pretty disappointed with X", "Not as good as expected", "Having issues with" |
| -2 | Strong Negative | Active warning, anger, advocacy against | "Stay away from X", "Worst experience ever", "Canceling and never going back" |

### Contextual Sentiment Signals

**Platform-specific sentiment patterns:**

**X (Twitter):**
- Sarcasm is common — read context carefully
- Quote tweets often indicate disagreement
- Thread length correlates with passion (positive or negative)
- Ratio (many replies, few likes) = negative signal

**Reddit:**
- Subreddit context affects interpretation
- Upvote/downvote ratio is a built-in sentiment meter
- "Honest opinion" or "real experience" posts tend to be genuine
- Award types indicate sentiment (gold = high positive)

**LinkedIn:**
- Professional filter makes everything seem more positive
- Absence of engagement can be a negative signal
- Comments are more honest than reactions
- "Interesting" or "thanks for sharing" = polite neutral, not positive

**YouTube:**
- Like/dislike ratio (where visible) is direct sentiment
- Comment sorting (top comments) shows community sentiment
- Timestamps in comments indicate what resonated

### Emotion Detection

Beyond positive/negative, identify specific emotions:

| Emotion | Signal Words | Business Implication |
|---------|-------------|---------------------|
| **Excitement** | "amazing", "game-changer", "love" | Advocacy potential — amplify |
| **Frustration** | "struggling", "annoying", "why can't" | UX issue — fix or address |
| **Confusion** | "how do I", "doesn't make sense", "unclear" | Education opportunity |
| **Trust** | "reliable", "always works", "depend on" | Core strength — protect |
| **Distrust** | "sketchy", "not sure about", "risky" | Credibility issue — address with proof |
| **FOMO** | "everyone's using", "missing out", "need to try" | Market momentum — capitalize |
| **Apathy** | No engagement, generic responses | Relevance problem — reinvent |

## Sentiment Aggregation

### Weighted Sentiment Score

Not all mentions carry equal weight:

**Weight factors:**
- Author influence (follower count, engagement rate): 1x-5x
- Post engagement (likes, comments, shares): 1x-3x
- Platform authority (LinkedIn > X for B2B): 1x-2x
- Recency (last 7 days weighted more): 1x-2x

**Formula:**
```
Weighted Sentiment = Σ (sentiment_score × influence_weight × engagement_weight × recency_weight) / total_weighted_mentions
```

### Sentiment Trending

Track sentiment over time windows:
- **7-day trend:** Is sentiment improving or declining this week?
- **30-day trend:** What's the monthly direction?
- **Event correlation:** Did any event cause a sentiment shift?

**Trend categories:**
- **Improving:** +0.3 or more improvement over period
- **Stable:** Within ±0.3
- **Declining:** -0.3 or more decline over period
- **Volatile:** Large swings in both directions

## Sentiment Response Playbook

### Strong Positive (+2)
- **Action:** Amplify and engage
- Respond with gratitude
- Ask permission to share/repost
- Identify potential brand advocate
- Note what triggered this sentiment for replication

### Positive (+1)
- **Action:** Acknowledge and nurture
- Like/react to the post
- Respond with helpful additional value
- Note satisfaction drivers

### Neutral (0)
- **Action:** Monitor and provide value
- Answer questions helpfully
- Provide useful context
- Don't force sentiment — let quality speak

### Negative (-1)
- **Action:** Acknowledge and resolve
- Respond empathetically
- Offer solution or escalation path
- Track whether issue is isolated or systemic
- Flag for product/support team

### Strong Negative (-2)
- **Action:** Immediate attention
- Respond publicly with empathy and professionalism
- Take detailed conversation to DM/private
- Escalate to crisis protocol if widespread
- Track root cause for systemic fix
- Never argue publicly

## Sentiment Report Structure

```
## Sentiment Report: [Brand] — [Date Range]

### Overall Score
[Score] / [Scale] — [Direction: ↑ improving / ↓ declining / → stable]

### Distribution
Positive: ██████████░░ [X]% ([count])
Neutral:  ████░░░░░░░░ [X]% ([count])
Negative: ██░░░░░░░░░░ [X]% ([count])

### Top Positive Drivers
1. [Theme]: [X mentions] — Example: "[quote]"
2. [Theme]: [X mentions] — Example: "[quote]"

### Top Negative Drivers
1. [Theme]: [X mentions] — Example: "[quote]"
2. [Theme]: [X mentions] — Example: "[quote]"

### Sentiment by Platform
| Platform | Score | Positive | Negative | Volume |
|----------|-------|----------|----------|--------|

### Sentiment by Topic
| Topic | Score | Volume | Trend |
|-------|-------|--------|-------|

### Notable Mentions
- [Influential positive mention + link]
- [Influential negative mention + link]
- [High-engagement neutral mention + link]

### Recommendations
1. [Action based on sentiment data]
2. [Action based on sentiment data]
```
