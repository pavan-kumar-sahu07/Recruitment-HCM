export function validateJobRequisitionData(data, req) {
  console.log("Data In Validation ");
  console.log(data);

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  if (data.postingDate) {
    const postingDate = new Date(data.postingDate);
    postingDate.setHours(0, 0, 0, 0);

    if (postingDate < today) {
      req.error(400, "Posting Date cannot be in the past.");
    }
  }

  if (data.applicationDeadline) {
    const deadline = new Date(data.applicationDeadline);
    deadline.setHours(0, 0, 0, 0);

    if (deadline < today) {
      req.error(400, "Application Deadline can't be in the past.");
    }
  }

  if (data.numberOfPositions == null || data.numberOfPositions <= 0) {
    req.error(400, "Number of positions must be greater than 0.");
  }

  if (
    data.salaryRangeMax != null &&
    data.salaryRangeMin != null &&
    Number(data.salaryRangeMax) <= Number(data.salaryRangeMin)
  ) {
    req.error(400, "Maximum salary must be greater than minimum salary.");
  }
}
