---
title: Contact preferences
---
<section>
<script src='https://www.google.com/recaptcha/api.js'></script>
<div class="container">
<div class="row">
<h1>Contact preferences</h1>
<form action="https://www.getdrip.com/forms/100795813/submissions" method="post" data-drip-embedded-form="100795813">
  <h3 data-drip-attribute="headline">Newsletter subscription update</h3>
  <div data-drip-attribute="description"></div>
    <p>
    <div>
        <label for="drip-email">Email Address</label><br />
        <input type="email" id="drip-email" name="fields[email]" value="" />
    </div>
    <div>
        <label for="drip-first-name">First name</label><br />
        <input type="text" id="drip-first-name" name="fields[first_name]" value="" />
    </div>
    </p>
    <p>
    Tell us what type of emails you're up for receiving... we don't email a lot
    <div>
        <input type="hidden" name="fields[general_news]" value="no" />
        <label>
          <input type="checkbox" name="fields[general_news]" value="yes" />
          General news and happenings
        </label>
    </div>
    <div>
        <input type="hidden" name="fields[cucumber_pro]" value="no" />
        <label>
          <input type="checkbox" name="fields[cucumber_pro]" value="yes" />
          Cucumber Pro updates
        </label>
    </div>
    <div>
        <input type="hidden" name="fields[us_events]" value="no" />
        <label>
          <input type="checkbox" name="fields[us_events]" value="yes" />
          USA events
        </label>
    </div>
    <div>
        <input type="hidden" name="fields[european_events]" value="no" />
        <label>
          <input type="checkbox" name="fields[european_events]" value="yes" />
          European events
        </label>
    </div>
    <div>
        <input type="hidden" name="fields[blog_posts]" value="no" />
        <label>
          <input type="checkbox" name="fields[blog_posts]" value="yes" />
          Blog posts
        </label>
    </div>
    </p>
    <p>
        <input type="checkbox" name="fields[eu_consent]" id="drip-eu-consent" value="granted">
        <label for="drip-eu-consent">I understand and agree to our [Privacy Policy](https://cucumber.io/privacy)</a></label>
    </p>
    <p>
        <input type="hidden" name="fields[eu_consent_message]" value="I understand and agree to our [Privacy Policy](https://cucumber.io/privacy)">
    </p>
    <p>
    <div class="g-recaptcha" data-sitekey="6LfQp1kUAAAAACBmoyERumB2x0eoDAwmYxta-Wbz"></div>
    </p>
  <p>
    <input type="submit" value="Update your preferences" data-drip-attribute="sign-up-button" />
  </p>
</form>
</div>
</div>
</section>
