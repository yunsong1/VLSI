function log_probs = log_softmax(logits)
    max_logit = max(logits);
    shifted_logits = logits - max_logit;
    exp_shifted_logits = exp(shifted_logits);
    sum_exp = sum(exp_shifted_logits);
    log_probs = shifted_logits - log(sum_exp);
end