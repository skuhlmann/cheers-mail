class EpisodeMailer < ActionMailer::Base
  default from: "DoNotReply@ThatOneEpisode.us"

  def weekly_episode_email(subscription)
    @subscription = subscription
    @episode = subscription.random_episode

    mail(to: @subscription.email_address,
         subject: "Do You Remember That One Episode of #{@episode.series.name}?")
  end
end
